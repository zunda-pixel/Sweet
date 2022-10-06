//
//  PostMediaModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  /// Post Media Model
  public struct PostMediaModel: Sendable {
    public var mediaIDs: [String]
    public var taggedUserIDs: [String]
    
    public init(mediaIDs: [String] = [], taggedUserIDs: [String] = []) {
      self.mediaIDs = mediaIDs
      self.taggedUserIDs = taggedUserIDs
    }
  }
}

extension Sweet.PostMediaModel: Encodable {
  private enum CodingKeys: String, CodingKey {
    case mediaIDs = "media_ids"
    case taggedUserIDs = "tagged_user_ids"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(mediaIDs, forKey: .mediaIDs)
    try container.encode(taggedUserIDs, forKey: .taggedUserIDs)
  }
}
