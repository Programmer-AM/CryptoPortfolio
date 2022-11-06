//
//  HomeViewModel.swift
//  CryptoPortfolio
//
//  Created by Miljan on 25.6.22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

  @Published var statistics: [StatisticModel] = []

  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  @Published var isLoading: Bool = false
  @Published var searchText: String = ""
  @Published var sortOption: SortOption = .holdings

  private let coinDataService = CoinDataService()
  private let marketDataSevice = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  private var cancellables = Set<AnyCancellable>()

  enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
  }

  init() {
    addSubscribers()
  }

  func addSubscribers() {

    // updates allCoins
    $searchText
      .combineLatest(coinDataService.$allCoins, $sortOption)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterAndSortCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)

    // updates portfolio coins
    $allCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map(mapAllCoinsToPortfolioCoins)
      .sink { [weak self] returnedCoins in
        guard let self = self else { return }
        self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
      }
      .store(in: &cancellables)

    // updates marketData
    marketDataSevice.$marketData
      .combineLatest($portfolioCoins)
      .map(mapGlobalMarketData)
      .sink { [weak self] returnedStats in
        self?.statistics = returnedStats
        self?.isLoading = false
      }
      .store(in: &cancellables)
  }

  func updatePortfolio(coin: CoinModel, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }

  func reloadData() {
    isLoading = true
    coinDataService.getCoins()
    marketDataSevice.getData()
    HapticManager.notification(type: .success)
  }
}

private extension HomeViewModel {

  func filterAndSortCoins(text: String, coins: [CoinModel], sortOption: SortOption) -> [CoinModel] {
    var updatedCoins = filterCoins(text: text, coins: coins)
    sortCoins(sort: sortOption, coins: &updatedCoins)
    return updatedCoins
  }

  func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else {
      return coins
    }

    let lowercaseText = text.lowercased()

    let filteredCoins = coins.filter { coin in
      return coin.name.lowercased().contains(lowercaseText) ||
      coin.symbol.lowercased().contains(lowercaseText) ||
      coin.id.lowercased().contains(lowercaseText)
    }
    return filteredCoins
  }

  func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
    switch sort {
    case .rank, .holdings:
      coins.sort(by: {$0.rank < $1.rank})
    case .rankReversed, .holdingsReversed:
      coins.sort(by: {$0.rank > $1.rank})
//    case .holdings:
//      return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
//    case .holdingsReversed:
//      return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
    case .price:
      coins.sort(by: {$0.currentPrice > $1.currentPrice})
    case .priceReversed:
      coins.sort(by: {$0.currentPrice < $1.currentPrice})
    }
  }

  private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
    // will only sort by holdings or reversedholdings if needed
    switch sortOption {
    case .holdings:
      return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
    case .holdingsReversed:
      return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
    default:
      return coins
    }
  }

  func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PorfolioEntity]) -> [CoinModel] {
    allCoins
      .compactMap { coin -> CoinModel? in
        guard let entity = portfolioEntities.first(where: { $0.coinId == coin.id }) else {
          return nil
        }
        return coin.updateHolding(amount: entity.amount)
      }
  }

  func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
    var stats: [StatisticModel] = []
    guard let data = marketDataModel else { return stats }
    let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    let volume = StatisticModel(title: "24h Volume", value: data.volume)
    let bitcoinDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)

    let portfolioValue = portfolioCoins
      .map(\.currentHoldingsValue)
      .reduce(0, +)

    let previousValue = portfolioCoins
      .map { coin -> Double in
        let currentValue = coin.currentHoldingsValue
        let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
        let previousValue = currentValue / (1 + percentChange)
        return previousValue
      }
      .reduce(0, +)

    let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100

    let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
    stats.append(contentsOf: [
      marketCap, volume, bitcoinDominance, portfolio
    ])
    return stats
  }
}
