//
//  OrganicMetricsModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  ///  Organic Metrics
  public struct OrganicMetrics: Hashable, Sendable {
    public let likeCount: Int
    public let userProfileClicks: Int
    public let replyCount: Int
    public let impressionCount: Int
    public let retweetCount: Int

    public init(
      likeCount: Int,
      userProfileClicks: Int,
      replyCount: Int,
      impressionCount: Int,
      retweetCount: Int
    ) {
      self.likeCount = likeCount
      self.userProfileClicks = userProfileClicks
      self.replyCount = replyCount
      self.impressionCount = impressionCount
      self.retweetCount = retweetCount
    }
  }
}

extension Sweet.OrganicMetrics: Codable {
  private enum CodingKeys: String, CodingKey {
    case likeCount = "like_count"
    case userProfileClicks = "user_profile_clicks"
    case replyCount = "reply_count"
    case impressionCount = "impression_count"
    case retweetCount = "retweet_count"
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.likeCount = try container.decode(Int.self, forKey: .likeCount)
    self.userProfileClicks = try container.decode(Int.self, forKey: .userProfileClicks)
    self.replyCount = try container.decode(Int.self, forKey: .replyCount)
    self.impressionCount = try container.decode(Int.self, forKey: .impressionCount)
    self.retweetCount = try container.decode(Int.self, forKey: .retweetCount)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(likeCount, forKey: .likeCount)
    try container.encode(userProfileClicks, forKey: .userProfileClicks)
    try container.encode(replyCount, forKey: .replyCount)
    try container.encode(impressionCount, forKey: .impressionCount)
    try container.encode(retweetCount, forKey: .retweetCount)
  }
}
