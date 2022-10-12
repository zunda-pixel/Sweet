//
//  StreamRuleSummary.swift
//

import Foundation

extension Sweet {
  public struct StreamRuleSummary: Hashable, Sendable {
    public let created: Int
    public let notCreated: Int
    public let valid: Int
    public let invalid: Int
  }
}

extension Sweet.StreamRuleSummary: Codable {
  private enum CodingKeys: String, CodingKey {
    case created
    case notCreated = "not_created"
    case valid
    case invalid
  }
}
