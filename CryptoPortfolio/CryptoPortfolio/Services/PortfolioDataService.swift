//
//  PortfolioDataService.swift
//  CryptoPortfolio
//
//  Created by Miljan on 10.7.22.
//

import Foundation
import CoreData

class PortfolioDataService {

  private let container: NSPersistentContainer
  private let containerName: String = "PortfolioContainer"
  private let entityName: String = "PorfolioEntity"

  @Published var savedEntities: [PorfolioEntity] = []

  init() {
    container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading Core Data! \(error)")
      }
    }
    getPortfolio()
  }

  // MARK: PUBLIC

  func updatePortfolio(coin: CoinModel, amount: Double) {

    // check if coin is already in portfolio
    if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
      if amount > 0 {
        update(entity: entity, amount: amount)
      } else {
        remove(entity: entity)
      }
    } else {
      add(coin: coin, amount: amount)
    }
  }

  // MARK: PRIVATE

  private func getPortfolio() {
    let request = NSFetchRequest<PorfolioEntity>(entityName: entityName)
    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch {
      print("Error fetching Porfolio Entities. \(error)")
    }
  }

  private func add(coin: CoinModel, amount: Double) {
    let entity = PorfolioEntity(context: container.viewContext)
    entity.coinId = coin.id
    entity.amount = amount
    applyChanges()
  }

  private func update(entity: PorfolioEntity, amount: Double) {
    entity.amount = amount
    applyChanges()
  }

  private func remove(entity: PorfolioEntity) {
    container.viewContext.delete(entity)
    applyChanges()
  }

  private func save() {
    do {
      try container.viewContext.save()
    } catch {
      print("Error saving to Core Data. \(error)")
    }
  }

  private func applyChanges() {
    save()
    getPortfolio()
  }
}
