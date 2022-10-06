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
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try values.decode(String.self, forKey: .id)
    let type = try values.decode(String.self, forKey: .type)
    self.type = .init(rawValue: type)!
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(type.rawValue, forKey: .type)
  }
}
