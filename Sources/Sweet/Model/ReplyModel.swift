//
//  ReplyModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  public struct ReplyModel {
    public var excludeReplyUserIDs: [String]
    public var replyToTweetIDs: [String]
    
    public init(excludeReplyUserIDs: [String] = [], replyToTweetIDs: [String] = []) {
      self.excludeReplyUserIDs = excludeReplyUserIDs
      self.replyToTweetIDs = replyToTweetIDs
    }
  }
}

extension Sweet.ReplyModel: Encodable {
  private enum CodingKeys: String, CodingKey {
    case excludeReplyUserIDs = "exclude_replay_user_ids"
    case replyToTweetIDs = "in_reply_to_tweet_id"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(excludeReplyUserIDs, forKey: .excludeReplyUserIDs)
    try container.encode(replyToTweetIDs, forKey: .replyToTweetIDs)
  }
}
