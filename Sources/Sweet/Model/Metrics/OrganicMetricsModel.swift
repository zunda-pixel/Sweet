//
//  OrganicMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public  struct OrganicMetricsModel {
  public let likeCount: Int
  public let userProfileClicks: Int
  public let replyCount: Int
  public let impressionCount: Int
  public let retweetCount: Int
}

extension OrganicMetricsModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case likeCount = "like_count"
    case userProfilleClicks = "user_profile_clicks"
    case replyCount = "reply_count"
    case impressionCount = "impression_count"
    case retweetCount = "retweet_count"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.likeCount = try values.decode(Int.self, forKey: .likeCount)
    self.userProfileClicks = try values.decode(Int.self, forKey: .userProfilleClicks)
    self.replyCount = try values.decode(Int.self, forKey: .replyCount)
    self.impressionCount = try values.decode(Int.self, forKey: .impressionCount)
    self.retweetCount = try values.decode(Int.self, forKey: .retweetCount)
  }
}
