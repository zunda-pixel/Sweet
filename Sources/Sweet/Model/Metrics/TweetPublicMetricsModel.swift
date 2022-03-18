//
//  TweetPublicMetricsModel 4.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct TweetPublicMetricsModel {
  public let retweetCount: Int
  public let replyCount: Int
  public let likeCount: Int
  public let quoteCount: Int
}

extension TweetPublicMetricsModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case retweetCount = "retweet_count"
    case replyCount = "reply_count"
    case likeCount = "like_count"
    case quoteCount = "quote_count"
  }
}
