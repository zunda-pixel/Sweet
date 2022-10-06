//
//  GeoModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  /// Geo Model
  public struct GeoModel: Hashable, Identifiable, Sendable {
    public var id: String { placeID }

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
