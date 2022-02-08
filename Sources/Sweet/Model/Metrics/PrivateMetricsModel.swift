//
//  PrivateMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct PrivateMetricsModel: Decodable {
  let impressionCount: Int
  let userProfilleClicks: Int
  
  private enum CodingKeys: String, CodingKey {
    case userProfilleClicks = "user_profile_clicks"
    case impressionCount = "impression_count"
  }
}
