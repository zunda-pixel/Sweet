//
//  TweetPublicMetricsModel 4.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct TweetPublicMetricsModel: Decodable {
  let retweetCount: Int
  let replyCount: Int
  let likeCount: Int
  let quoteCount: Int
  
  private enum CodingKeys: String, CodingKey {
    case retweetCount = "retweet_count"
    case replyCount = "reply_count"
    case likeCount = "like_count"
    case quoteCount = "quote_count"
  }
}
