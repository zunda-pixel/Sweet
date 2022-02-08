//
//  OrganicMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public  struct OrganicMetricsModel: Decodable {
  let likeCount: Int
  let userProfilleClicks: Int
  let replyCount: Int
  let impressionCount: Int
  let retweetCount: Int
  
  private enum CodingKeys: String, CodingKey {
    case likeCount = "like_count"
    case userProfilleClicks = "user_profile_clicks"
    case replyCount = "reply_count"
    case impressionCount = "impression_count"
    case retweetCount = "retweet_count"
  }
}
