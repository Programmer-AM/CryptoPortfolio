//
//  CoinImageService.swift
//  CryptoPortfolio
//
//  Created by Miljan on 4.7.22.
//

import Foundation
import UIKit
import Combine

class CoinImageService {

  @Published var image: UIImage? = nil

  private var imageSubscription: AnyCancellable?
  private let coin: CoinModel
  private let fileManager = LocalFileManager.instance
  private let folderName = "coin_images"

  private var imageName: String {
    coin.id
  }

  init(coin: CoinModel) {
    self.coin = coin
    getCoinImage()
  }

  private func getCoinImage() {
    if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
      image = savedImage
      print("Retrieved image from File Manager!")
    } else {
      downloadCoinImage()
      print("Downloading image now...")
    }
  }

  private func downloadCoinImage() {
    guard let url = URL(string: coin.image) else {
      return
    }

    imageSubscription = NetworkingManager.download(url: url)
      .tryMap({ data -> UIImage? in
        return UIImage(data: data)
      })
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
        guard let self = self,
              let downloadedImage = returnedImage else { return }
        self.image = returnedImage
        self.imageSubscription?.cancel()
        self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
      })
  }
}
