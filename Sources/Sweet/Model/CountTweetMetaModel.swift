//
//  CountTweetMetaModel.swift
//
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  /// Count Tweet Meta Model
  public struct CountTweetMetaModel: Hashable, Sendable {
    public let totalTweetCount: Int
    public let nextToken: String?

    public init(totalTweetCount: Int, nextToken: String? = nil) {
      self.totalTweetCount = totalTweetCount
      self.nextToken = nextToken
    }
  }
}

extension Sweet.CountTweetMetaModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case totalTweetCount = "total_tweet_count"
    case nextToken = "next_token"
  }
}
