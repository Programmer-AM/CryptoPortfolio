//
//  PorfolioView.swift
//  CryptoPortfolio
//
//  Created by Miljan on 9.7.22.
//

import SwiftUI

struct PorfolioView: View {

  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject private var vm: HomeViewModel
  @State private var selectedCoin: CoinModel? = nil
  @State private var quantityText: String = ""
  @State private var showCheckmark: Bool = false

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: .zero) {
          SearchBarView(searchText: $vm.searchText)
          coinLogoList

          if selectedCoin != nil {
            portfolioInputSection
          }
        }
        .navigationTitle("Edit Porfolio")
        .toolbar(content: {
          //          ToolbarItem(placement: .navigationBarLeading) {
          //            XMarkButton()
          //              .environment(\.presentationMode, true)
          //          }
          ToolbarItem(placement: .navigationBarTrailing) {
            trailingNavBarButtons
          }
        })
        .onChange(of: vm.searchText) { value in
          if value == "" {
            removeSelectedCoin()
          }
        }
      }
      .background(
        Color.theme.background
          .ignoresSafeArea()
      )
    }
  }
}

extension PorfolioView {

  private var coinLogoList: some View {
    ScrollView(.horizontal, showsIndicators: false, content: {
      LazyHStack(spacing: 10) {
        ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
          CoinLogoView(coin: coin)
            .frame(width: 75)
            .padding(4)
            .onTapGesture {
              withAnimation(.easeIn) {
                updateSelectedCoin(coin: coin)
              }
            }
            .background(
              RoundedRectangle(cornerRadius: 10)
                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                        lineWidth: 1)
            )
        }
      }
      .frame(height: 120)
      .padding(.leading)
    })
  }

  private func updateSelectedCoin(coin: CoinModel) {
    selectedCoin = coin
    if let portofioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
       let amount = portofioCoin.currentHoldings {
      quantityText = "\(amount)"
    } else {
      quantityText = ""
    }
  }

  private func getCurrentValue() -> Double {
    if let quantity = Double(quantityText) {
      return quantity * (selectedCoin?.currentPrice ?? 0)
    }
    return 0
  }

  private var portfolioInputSection: some View {
    VStack(spacing: 20) {
      HStack {
        Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
        Spacer()
        Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
      }
      Divider()
      HStack {
        Text("Amount holding:")
        Spacer()
        TextField("Ex: 1.4", text: $quantityText)
          .multilineTextAlignment(.trailing)
          .keyboardType(.decimalPad)
      }
      Divider()
      HStack {
        Text("Current value:")
        Spacer()
        Text(getCurrentValue().asCurrencyWith2Decimals())
      }
    }
    .animation(.none)
    .padding()
    .font(.headline)
  }

  private var trailingNavBarButtons: some View {
    HStack(spacing: 10) {
      Image(systemName: "checkmark")
        .opacity(showCheckmark ? 1.0 : 0.0)
      Button {
        saveButtonPressed()
      } label: {
        Text("Save".uppercased())
      }
      .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
    }
    .font(.headline)
  }

  private func saveButtonPressed() {
    guard
      let coin = selectedCoin,
      let amount = Double(quantityText)
    else { return }

    // save to portfolio
    vm.updatePortfolio(coin: coin, amount: amount)
    
    // show checkmark
    withAnimation(.easeIn) {
      showCheckmark = true
      removeSelectedCoin()
    }

    // hide keyboard
    UIApplication.shared.endEditing()

    // hide checkmark
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      withAnimation(.easeOut) {
        showCheckmark = false
      }
    }
  }

  private func removeSelectedCoin() {
    selectedCoin = nil
    vm.searchText = ""
  }
}

struct PorfolioView_Previews: PreviewProvider {
  static var previews: some View {
    PorfolioView()
      .environmentObject(dev.homeVM)
  }
}
