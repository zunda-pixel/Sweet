//
//  CountTweetMetaModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

public struct CountTweetMetaModel {
  public let totalTweetCount: Int
  public let nextToken: Int?
}

extension CountTweetMetaModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case totalTweetCount = "total_tweet_count"
    case nextToken = "next_token"
  }
}
