//
//  SettingsView.swift
//  CryptoPortfolio
//
//  Created by Miljan on 31.7.22.
//

import SwiftUI

struct SettingsView: View {

  let defaultURL = URL(string: "http://www.google.com")!
  let coingeckoURL = URL(string: "https://www.coingecko.com")!

  var body: some View {
    NavigationView {
      ZStack {
        // background
        Color.theme.background
          .ignoresSafeArea()

        // content layer
        List {
          coinGeckoSection
            .listRowBackground(Color.theme.background.opacity(0.5))
          developerSection
            .listRowBackground(Color.theme.background.opacity(0.5))
          applicationSection
            .listRowBackground(Color.theme.background.opacity(0.5))
        }
      }
      .font(.headline)
      .accentColor(.blue)
      .listStyle(GroupedListStyle())
      .navigationTitle("Settings")
    }
  }
}

extension SettingsView {

  private var coinGeckoSection: some View {
    Section(header: Text("Coin Gecko")) {
      VStack(alignment: .leading) {
        Image("coingecko")
          .resizable()
          .scaledToFit()
          .frame(height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(.theme.accent)
      }
      .padding(.vertical)
      Link("Visit CoinGecko 🦎", destination: coingeckoURL)
    }
  }

  private var developerSection: some View {
    Section(header: Text("Developer")) {
      VStack(alignment: .leading) {
        Image("logo")
          .resizable()
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("This app was developed by Miljan Angjelovik as part of my graduation thesis. I uses SwiftUI, publishers/subscribers and data persistance.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(.theme.accent)
      }
      .padding(.vertical)
    }
  }

  private var applicationSection: some View {
    Section(header: Text("Application")) {
      Link("Terms of Service", destination: defaultURL)
      Link("Privacy Policy", destination: defaultURL)
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
