//
//  StreamRuleModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Stream Rule Model
  public struct StreamRuleModel: Hashable, Identifiable, Sendable, Codable {
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
