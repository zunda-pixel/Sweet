//
//  OrganicMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public  struct OrganicMetricsModel: Decodable {
  public let likeCount: Int
  public let userProfileClicks: Int
  public let replyCount: Int
  public let impressionCount: Int
  public let retweetCount: Int
  
  public init(likeCount: Int, userProfileClicks: Int,
              replyCount: Int, imporessionCount: Int, retweetCount: Int) {
    self.likeCount = likeCount
    self.userProfileClicks = userProfileClicks
    self.replyCount = replyCount
    self.impressionCount = impressionCount
    self.retweetCount = retweetCount
  }
  
  private enum CodingKeys: String, CodingKey {
    case likeCount = "like_count"
    case userProfilleClicks = "user_profile_clicks"
    case replyCount = "reply_count"
    case impressionCount = "impression_count"
    case retweetCount = "retweet_count"
  }
}
