//
//  ReplyModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

public struct ReplyModel {
  public let excludeReplyUserIDs: [String]
  public let inReplyToTweetID: [String]
}

extension ReplyModel: Encodable {
  private enum CodingKeys: String, CodingKey {
    case excludeReplyUserIDs = "exclude_replay_user_ids"
    case inReplyToTweetID = "in_reply_to_tweet_id"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(excludeReplyUserIDs, forKey: .excludeReplyUserIDs)
    try container.encode(inReplyToTweetID, forKey: .inReplyToTweetID)
  }
}
