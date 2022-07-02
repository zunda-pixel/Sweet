//
//  PrivateMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Private Metrics
  public struct PrivateMetrics: Hashable {
    public let impressionCount: Int
    public let userProfileClicks: Int
    
    public init(impressionCount: Int, userProfileClicks: Int) {
      self.impressionCount = impressionCount
      self.userProfileClicks = userProfileClicks
    }
  }
}

extension Sweet.PrivateMetrics: Codable {  
  private enum CodingKeys: String, CodingKey {
    case userProfileClicks = "user_profile_clicks"
    case impressionCount = "impression_count"
  }
}
