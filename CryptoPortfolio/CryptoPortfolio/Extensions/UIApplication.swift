//
//  UIApplication.swift
//  CryptoPortfolio
//
//  Created by Miljan on 4.7.22.
//

import Foundation
import UIKit

extension UIApplication {

  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
