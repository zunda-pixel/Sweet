//
//  SimpleGeo.swift
//

import Foundation

extension Sweet {
  /// SimpleGeo Model
  public struct SimpleGeoModel: Hashable, Identifiable, Sendable {
    public var id: String { placeID }

    public let placeID: String

    public init(placeID: String) {
      self.placeID = placeID
    }
  }
}

extension Sweet.SimpleGeoModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case placeID = "place_id"
  }
}
