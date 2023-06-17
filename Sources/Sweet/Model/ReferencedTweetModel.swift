//
//  ReferencedTweetModel.swift
//
//
//  Created by zunda on 2022/03/16.
//

import Foundation

extension Sweet {
  /// Referenced Tweet Model
  public struct ReferencedTweetModel: Hashable, Sendable {
    public let id: String
    public let type: ReferencedType

    public init(id: String, type: ReferencedType) {
      self.id = id
      self.type = type
    }
  }
}

extension Sweet.ReferencedTweetModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case type
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    let type = try container.decode(String.self, forKey: .type)
    self.type = Sweet.ReferencedType(rawValue: type)!
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(type.rawValue, forKey: .type)
  }
}
