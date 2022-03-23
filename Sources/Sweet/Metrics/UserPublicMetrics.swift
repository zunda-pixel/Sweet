//
//  UserPublicMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct UserPublicMetrics {
    public let followersCount: Int
    public let followingCount: Int
    public let tweetCount: Int
    public let listedCount: Int
    
    public init(followersCount: Int, followingCount: Int, tweetCount: Int, listedCount: Int) {
      self.followersCount = followersCount
      self.followingCount = followingCount
      self.tweetCount = tweetCount
      self.listedCount = listedCount
    }
  }
}


extension Sweet.UserPublicMetrics: Codable {
  private enum CodingKeys: String, CodingKey {
    case followersCount = "followers_count"
    case followingCount = "following_count"
    case tweetCount = "tweet_count"
    case listedCount = "listed_count"
  }
}
