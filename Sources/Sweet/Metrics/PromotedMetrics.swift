//
//  PromotedMetrics.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct PromotedMetrics: Hashable {
    public let impressionCount: Int
    public let urlLinkClicks: Int
    public let userProfileClicks: Int
    public let retweetCount: Int
    public let replyCount: Int
    
    public init(impressionCount: Int, urlLinkClicks: Int, userProfileClicks: Int, retweetCount: Int, replyCount: Int) {
      self.impressionCount = impressionCount
      self.urlLinkClicks = urlLinkClicks
      self.userProfileClicks = userProfileClicks
      self.retweetCount = retweetCount
      self.replyCount = replyCount
    }
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
