//
//  SimpleGeo.swift
//

import Foundation

extension Sweet {
  /// SimpleGeo Model
  public struct SimpleGeoModel: Hashable, Sendable {
    public let placeID: String?
    public let coordinates: CoordinatesModel
    
    public init(placeID: String? = nil, coordinates: CoordinatesModel) {
      self.placeID = placeID
      self.coordinates = coordinates
    }
  }
}

extension Sweet.SimpleGeoModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case placeID = "place_id"
    case coordinates
  }
}
