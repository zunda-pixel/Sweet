//
//  PrivateMetricsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct PrivateMetricsModel {
  public let impressionCount: Int
  public let userProfilleClicks: Int
}

extension PrivateMetricsModel: Decodable {  
  private enum CodingKeys: String, CodingKey {
    case userProfilleClicks = "user_profile_clicks"
    case impressionCount = "impression_count"
  }
}
