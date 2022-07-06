//
//  SendListModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Post List Model
  public struct PostListModel: Hashable {
    public let name: String?
    public let description: String?
    public let isPrivate: Bool?
  }
}

extension Sweet.PostListModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case name
    case description
    case isPrivate = "private"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if let name {
      try container.encode(name, forKey: .name)
    }
    if let description {
      try container.encode(description, forKey: .description)
    }
    if let isPrivate {
      try container.encode(isPrivate, forKey: .isPrivate)
    }
  }
}
