//
//  DomainModel.swift
//

import Foundation

extension Sweet {
  /// Domain Model
  public struct DomainModel: Hashable, Identifiable, Sendable, Codable {
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
