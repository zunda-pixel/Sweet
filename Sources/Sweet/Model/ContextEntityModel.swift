//
//  ContextEntityModel.swift
//

import Foundation

extension Sweet {
  /// Context Entity Model
  public struct ContextEntityModel: Hashable, Identifiable, Sendable, Codable {
    public let id: String
    public let name: String
    public let description: String?

    public init(
      id: String,
      name: String,
      description: String? = nil
    ) {
      self.id = id
      self.name = name
      self.description = description
    }
  }
}
