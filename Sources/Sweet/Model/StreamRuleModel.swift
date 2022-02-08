//
//  StreamRuleModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct StreamRuleModel: Codable {
  public let id: String
  public let value: String
  public let tag: String?
  
  public init(value: String, tag: String? = nil) {
    self.id = ""
    self.tag = tag
    self.value = value
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value, forKey: .value)
    if let tag = tag {
        try container.encode(tag, forKey: .tag)
    }
  }
}
