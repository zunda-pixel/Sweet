//
//  TweetPublicMetricsModel 4.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct TweetPublicMetrics: Hashable {
    public let retweetCount: Int
    public let replyCount: Int
    public let likeCount: Int
    public let quoteCount: Int
    
    public init(retweetCount: Int, replyCount: Int, likeCount: Int, quoteCount: Int) {
      self.retweetCount = retweetCount
      self.replyCount = replyCount
      self.likeCount = likeCount
      self.quoteCount = quoteCount
    }
  }
}

extension Sweet.TweetPublicMetrics: Codable {
  private enum CodingKeys: String, CodingKey {
    case retweetCount = "retweet_count"
    case replyCount = "reply_count"
    case likeCount = "like_count"
    case quoteCount = "quote_count"
  }
}
