//
//  GeoModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  public struct GeoModel {
    public let placeID: String
    
    public init(placeID: String) {
      self.placeID = placeID
    }
  }
}

extension Sweet.GeoModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case placeID = "place_id"
  }
}
