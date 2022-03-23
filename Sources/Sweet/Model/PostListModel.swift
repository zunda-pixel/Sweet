//
//  SendListModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct PostListModel {
    public let name: String?
    public let description: String?
    public let isPrivate: Bool?
    
    public init(name: String? = nil, description: String? = nil, isPrivate: Bool? = nil) {
      self.name = name
      self.description = description
      self.isPrivate = isPrivate
    }
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
    if let name = name {
      try container.encode(name, forKey: .name)
    }
    if let description = description {
      try container.encode(description, forKey: .description)
    }
    if let isPrivate = isPrivate  {
      try container.encode(isPrivate, forKey: .isPrivate)
    }
  }
}
