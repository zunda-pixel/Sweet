//
//  ReferencedTweetModel.swift
//  
//
//  Created by zunda on 2022/03/16.
//

import Foundation

extension Sweet {
  public struct ReferencedTweetModel {
    public let id: String
    public let type: ReferencedType
  }
}

extension Sweet.ReferencedTweetModel: Decodable {
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
}