//
//  StreamRuleModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Stream Rule Model
  public struct StreamRuleModel: Hashable, Identifiable {
    public let id: String
    public let value: String
    public let tag: String?
    
    public init(value: String, tag: String? = nil) {
      self.id = ""
      self.tag = tag
      self.value = value
    }
  }
}

extension Sweet.StreamRuleModel: Codable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value, forKey: .value)
    if let tag {
      try container.encode(tag, forKey: .tag)
    }
  }
}
