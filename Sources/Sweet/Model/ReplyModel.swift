//
//  ReplyModel.swift
//
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  /// ReplyModel
  public struct ReplyModel: Sendable {
    public var replyToTweetID: String
    public var excludeReplyUserIDs: [String]

    public init(replyToTweetID: String, excludeReplyUserIDs: [String] = []) {
      self.replyToTweetID = replyToTweetID
      self.excludeReplyUserIDs = excludeReplyUserIDs
    }
  }
}

extension Sweet.ReplyModel: Encodable {
  private enum CodingKeys: String, CodingKey {
    case excludeReplyUserIDs = "exclude_reply_user_ids"
    case replyToTweetID = "in_reply_to_tweet_id"
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(replyToTweetID, forKey: .replyToTweetID)

    if !excludeReplyUserIDs.isEmpty {
      try container.encode(excludeReplyUserIDs, forKey: .excludeReplyUserIDs)
    }
  }
}
