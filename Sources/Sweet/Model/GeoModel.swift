//
//  GeoModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

public struct GeoModel: Codable {
  public let placeID: String
  
  private enum CodingKeys: String, CodingKey {
    case placeID = "place_id"
  }
}
