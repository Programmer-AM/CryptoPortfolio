//
//  CoinRowView.swift
//  CryptoPortfolio
//
//  Created by Miljan on 29.5.22.
//

import SwiftUI

struct CoinRowView: View {

  let coin: CoinModel
  let showHoldingsColumn: Bool

  var body: some View {
    HStack(spacing: 0) {
      leftColumn
      Spacer()
      if showHoldingsColumn {
        centralColumn
      }
      rightColumn
    }
    .font(.headline)
    .background(
      Color.theme.background.opacity(0.001)
    )
  }
}

extension CoinRowView {

  private var leftColumn: some View {
    HStack(spacing: 0) {
      Text("\(coin.rank)")
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .frame(minWidth: 30)
      CoinImageView(coin: coin)
        .frame(width: 30, height: 30)
      Text(coin.symbol.uppercased())
        .font(.headline)
        .padding(.leading, 6)
        .foregroundColor(.theme.accent)
    }
  }

  private var centralColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
        .foregroundColor(.theme.accent)
      Text((coin.currentHoldings ?? 0).asNumberString())
        .foregroundColor(.gray)
    }
  }

  private var rightColumn: some View {
    VStack(alignment: .trailing) {
      Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
        .bold()
        .foregroundColor(.theme.accent)

      Text(coin.priceChangePercentage24H?.asPercentString() ?? "0%")
        .foregroundColor((coin.priceChange24H ?? 0) >= 0 ? .theme.green : .theme.red)
    }
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}
