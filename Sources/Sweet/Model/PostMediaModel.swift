//
//  PostMediaModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

public struct PostMediaModel {
  public let mediaIDs: [String]
  public let taggedUserIDs: [String]
}

extension PostMediaModel: Encodable {
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
