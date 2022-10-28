//
//  DirectMessageReferencedTweetModel.swift
//

import Foundation

extension Sweet {
  /// DirectMessage Referenced Tweet Model
  public struct DirectMessageReferencedTweetModel: Hashable, Sendable, Codable {
    public let id: String

    public init(id: String) {
      self.id = id
    }
  }
}
