//
//  SimpleGeo.swift
//

import Foundation

extension Sweet {
  /// SimpleGeo Model
  public struct SimpleGeoModel: Hashable, Identifiable, Sendable {
    public var id: String { placeID }

    public let placeID: String
    public let coordinate: CoordinateModel
    
    public init(placeID: String, coordinate: CoordinateModel) {
      self.placeID = placeID
      self.coordinate = coordinate
    }
  }
}

extension Sweet.SimpleGeoModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case placeID = "place_id"
    case coordinate = "coordinates"
  }
}
