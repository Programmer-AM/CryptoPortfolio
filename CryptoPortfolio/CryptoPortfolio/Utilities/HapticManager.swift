//
//  HapticManager.swift
//  CryptoPortfolio
//
//  Created by Miljan on 17.7.22.
//

import Foundation
import UIKit

class HapticManager {

  static private let generator = UINotificationFeedbackGenerator()

  static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
}
