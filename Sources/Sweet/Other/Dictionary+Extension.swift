//
//  Dictionary+Extension.swift
//

import Foundation

extension Dictionary where Key == String, Value == String? {
  var removedEmptyValue: [String: String] {
    var dictionary = [String: String]()
    
    self.forEach {
      if let value = $0.value, !value.isEmpty {
        dictionary[$0.key] = value
      }
    }
    
    return dictionary
  }
}
