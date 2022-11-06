//
//  CoinModel.swift
//  CryptoPortfolio
//
//  Created by Miljan on 29.5.22.
//

import Foundation

// CoinGecko API info
/*
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h

 JSON Response:
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 29390,
     "market_cap": 560268922443,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 617533186517,
     "total_volume": 13886578102,
     "high_24h": 29409,
     "low_24h": 28873,
     "price_change_24h": 451.82,
     "price_change_percentage_24h": 1.56131,
     "market_cap_change_24h": 9749490220,
     "market_cap_change_percentage_24h": 1.77096,
     "circulating_supply": 19052656,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 69045,
     "ath_change_percentage": -57.40975,
     "ath_date": "2021-11-10T14:24:11.849Z",
     "atl": 67.81,
     "atl_change_percentage": 43266.42955,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2022-05-29T12:43:18.295Z",
     "sparkline_in_7d": {
       "price": [
         29919.258535544526,
         30195.853504758594,
         30059.79716769435,
         30009.759324959436,
         29888.987158689626,
         29958.666956261368,
         29978.384670416777,
         30049.27974428577,
         29976.10252024696,
         29974.13309415041,
         30069.910565295708,
         30341.531208439646,
         30351.050417138096,
         30300.123520864105,
         30233.304059660284,
         30162.200777993916,
         30169.673747371988,
         30172.13926006517,
         30276.76118473994,
         30528.731586363934,
         30546.4547069185,
         30381.50734327177,
         30495.217363563523,
         30483.75338516015,
         30440.18813153408,
         30433.124856438022,
         30435.747186647808,
         30278.200334421705,
         30415.521868185282,
         30292.474385454425,
         30104.347687672132,
         29998.513096702307,
         29231.832325497417,
         29339.48904783449,
         29392.00794876634,
         29219.5951408335,
         29135.362563102553,
         29179.22613289936,
         29254.361332338103,
         29294.55857934977,
         29316.325109179415,
         29378.433744223774,
         29369.613462231624,
         29294.103159102884,
         29404.765572808068,
         29225.280371935165,
         29310.803263531212,
         29348.30434667454,
         29281.64881987151,
         29275.102905605483,
         29058.5442424006,
         28971.612089682047,
         29273.849146237022,
         29341.05079474907,
         29354.60025384753,
         29149.293006524687,
         29398.13289445197,
         29449.13691004379,
         29571.144750896012,
         29614.208799995526,
         29655.02613175249,
         29624.23203844424,
         29744.344523718555,
         30136.3416441564,
         30167.08818126617,
         30092.519724929774,
         29873.22984021727,
         29784.789906201913,
         29724.86155963389,
         29840.461896471155,
         29834.745796762585,
         29747.33887815905,
         29400.949577852087,
         29533.14015053647,
         29665.332304404452,
         29794.237067560454,
         29633.85924749125,
         29542.275162557242,
         29722.297747260825,
         29857.90574100569,
         29678.696472760075,
         29804.499495362787,
         29827.949163555557,
         29766.591886390797,
         29584.949851985926,
         29812.846711106984,
         29684.052177964073,
         29864.386260796404,
         29842.378764054643,
         29780.158497210443,
         29707.930937383022,
         29669.681496268808,
         29740.292524544842,
         29032.516209702244,
         29159.44469889232,
         29171.450614546833,
         29092.29762956766,
         28958.5974927827,
         28893.906721961794,
         29269.306704908133,
         29422.1097662769,
         29609.88113051394,
         29632.43596114663,
         29633.147598648535,
         29449.983201248317,
         29505.32636894392,
         29602.45739665727,
         29545.825293413636,
         29346.781442431617,
         29211.525821933417,
         28996.307805346685,
         28974.632535857876,
         29054.061621878947,
         28948.96246085481,
         28828.44755984821,
         28928.059944615532,
         29078.446327272137,
         29019.21560114639,
         29048.091431795056,
         28848.77091725029,
         28939.540011111127,
         29236.673560623607,
         29326.830950317053,
         28845.348980599927,
         28881.721519841074,
         28754.39432050119,
         28448.80044008921,
         28486.025640799555,
         28878.634839699913,
         28821.98408502687,
         28779.481410277964,
         28865.701315269765,
         28646.65218193245,
         28832.192009012462,
         28626.738803809865,
         28725.32038731683,
         28838.551661998477,
         28857.839461661668,
         28887.334225062426,
         28888.104364964427,
         28895.378956149627,
         28862.654696467438,
         28829.13875063057,
         28833.516309187173,
         28877.91569285589,
         28993.96251520225,
         29094.581376072983,
         29006.51547707013,
         29037.074541372673,
         28981.66236833065,
         28898.439972588283,
         29003.81546773665,
         29038.935570579066,
         29011.337285452133,
         29061.88816390439,
         29018.734517289402,
         29088.236452817226,
         29040.921368496478,
         28965.490000870086,
         28943.20514893756,
         29011.715925045082,
         29000.473983361644,
         29057.875283109217,
         29083.57135465299,
         29033.787543462175,
         29128.788675474305,
         29030.86342052809,
         29173.180463833793
       ]
     },
     "price_change_percentage_24h_in_currency": 1.5613096622111056
   }
 */

struct CoinModel: Identifiable, Codable {
  let id, symbol, name: String
  let image: String
  let currentPrice: Double
  let marketCap, marketCapRank, fullyDilutedValuation: Double?
  let totalVolume, high24H, low24H: Double?
  let priceChange24H, priceChangePercentage24H: Double?
  let marketCapChange24H: Double?
  let marketCapChangePercentage24H: Double?
  let circulatingSupply, totalSupply, maxSupply, ath: Double?
  let athChangePercentage: Double?
  let athDate: String?
  let atl, atlChangePercentage: Double?
  let atlDate: String?
  let lastUpdated: String?
  let sparklineIn7D: SparklineIn7D?
  let priceChangePercentage24HInCurrency: Double?
  let currentHoldings: Double?

  enum CodingKeys: String, CodingKey {
    case id, symbol, name, image
    case currentPrice = "current_price"
    case marketCap = "market_cap"
    case marketCapRank = "market_cap_rank"
    case fullyDilutedValuation = "fully_diluted_valuation"
    case totalVolume = "total_volume"
    case high24H = "high_24h"
    case low24H = "low_24h"
    case priceChange24H = "price_change_24h"
    case priceChangePercentage24H = "price_change_percentage_24h"
    case marketCapChange24H = "market_cap_change_24h"
    case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
    case circulatingSupply = "circulating_supply"
    case totalSupply = "total_supply"
    case maxSupply = "max_supply"
    case ath
    case athChangePercentage = "ath_change_percentage"
    case athDate = "ath_date"
    case atl
    case atlChangePercentage = "atl_change_percentage"
    case atlDate = "atl_date"
    case lastUpdated = "last_updated"
    case sparklineIn7D = "sparkline_in_7d"
    case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    case currentHoldings

  }

  func updateHolding(amount: Double) -> CoinModel {
    return CoinModel(id: self.id, symbol: self.symbol, name: self.name, image: self.image, currentPrice: self.currentPrice, marketCap: self.marketCap, marketCapRank: self.marketCapRank, fullyDilutedValuation: self.fullyDilutedValuation, totalVolume: self.totalVolume, high24H: self.high24H, low24H: self.low24H, priceChange24H: self.priceChange24H, priceChangePercentage24H: self.priceChangePercentage24H, marketCapChange24H: self.marketCapChange24H, marketCapChangePercentage24H: self.marketCapChangePercentage24H, circulatingSupply: self.circulatingSupply, totalSupply: self.totalSupply, maxSupply: self.maxSupply, ath: self.ath, athChangePercentage: self.athChangePercentage, athDate: self.athDate, atl: self.atl, atlChangePercentage: self.atlChangePercentage, atlDate: self.atlDate, lastUpdated: self.lastUpdated, sparklineIn7D: self.sparklineIn7D, priceChangePercentage24HInCurrency: self.priceChangePercentage24HInCurrency, currentHoldings: amount)
  }

  var currentHoldingsValue: Double {
    (currentHoldings ?? 0) * currentPrice
  }

  var rank: Int {
    Int(marketCapRank ?? 0)
  }
}

struct SparklineIn7D: Codable {
  let price: [Double]?
}

