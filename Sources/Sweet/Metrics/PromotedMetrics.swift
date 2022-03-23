//
//  PromotedMetrics.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct PromotedMetrics {
    public let impressionCount: Int
    public let urlLinkClicks: Int
    public let userProfileClicks: Int
    public let retweetCount: Int
    public let replyCount: Int
  }
}

extension Sweet.PromotedMetrics: Codable {
  private enum CodingKeys: String, CodingKey {
    case impressionCount = "impression_count"
    case urlLinkClicks = "url_link_clicks"
    case userProfileClicks = "user_profile_clicks"
    case retweetCount = "retweet_count"
    case replyCount = "reply_count"
  }
}
