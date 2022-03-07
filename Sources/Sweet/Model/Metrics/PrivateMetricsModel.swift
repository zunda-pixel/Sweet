//
//  PrivateMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct PrivateMetricsModel: Decodable {
  public let impressionCount: Int
  public let userProfilleClicks: Int
  
  public init(impressionCount: Int, userProfileClicks: Int) {
    self.impressionCount = impressionCount
    self.userProfilleClicks = userProfileClicks
  }
  
  private enum CodingKeys: String, CodingKey {
    case userProfilleClicks = "user_profile_clicks"
    case impressionCount = "impression_count"
  }
}
