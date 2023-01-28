//
//  ComplianceModel.swift
//

import Foundation

extension Sweet {
  /// ComplianceModel
  public struct ComplianceModel: Sendable {
    public let id: String
    public let action: ComplianceAction
    public let createdAt: Date
    public let reason: ComplianceReason
    
    public init(
      id: String,
      action: ComplianceAction,
      createdAt: Date,
      reason: ComplianceReason
    ) {
      self.id = id
      self.action = action
      self.createdAt = createdAt
      self.reason = reason
    }
  }
}

extension Sweet.ComplianceModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case action
    case createdAt = "created_at"
    case reason
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)

    let action = try container.decode(String.self, forKey: .action)
    self.action = .init(rawValue: action)!

    self.createdAt = try container.decode(Date.self, forKey: .createdAt)

    let reason = try container.decode(String.self, forKey: .reason)
    self.reason = .init(rawValue: reason)!
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(action.rawValue, forKey: .action)
    try container.encode(createdAt, forKey: .createdAt)
    try container.encode(reason.rawValue, forKey: .reason)
  }
}
