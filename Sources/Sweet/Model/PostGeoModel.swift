//
//  PostGeoModel.swift
//

import Foundation

extension Sweet {
  /// PostGeo Model
  public struct PostGeoModel: Hashable, Sendable {
    public let placeID: String
    
    public init(placeID: String) {
      self.placeID = placeID
    }
  }
}

extension Sweet.PostGeoModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case placeID = "place_id"
  }
}
