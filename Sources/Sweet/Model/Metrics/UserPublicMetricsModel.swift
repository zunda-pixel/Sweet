//
//  UserPublicMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation


public struct UserPublicMetricsModel: Decodable {
  public let followersCount: Int
  public let followingCount: Int
  public let tweetCount: Int
  public let listedCount: Int
  
  private enum CodingKeys: String, CodingKey {
    case followersCount = "followers_count"
    case followingCount = "following_count"
    case tweetCount = "tweet_count"
    case listedCount = "listed_count"
  }
}
