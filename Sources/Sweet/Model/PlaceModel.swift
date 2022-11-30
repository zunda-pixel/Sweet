//
//  PlaceModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Place Model
  /// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/place
  public struct PlaceModel: Hashable, Identifiable, Sendable {
    public let id: String
    public let fullName: String
    public let name: String?
    public let country: String?
    public let countryCode: String?
    public let geo: GeoModel?
    public let type: PlaceType?
    public let containedWithin: [String]

    public init(
      id: String, fullName: String, name: String? = nil, country: String? = nil,
      countryCode: String? = nil, geo: GeoModel? = nil, type: PlaceType? = nil,
      containedWithin: [String] = []
    ) {
      self.id = id
      self.fullName = fullName
      self.name = name
      self.country = country
      self.countryCode = countryCode
      self.geo = geo
      self.type = type
      self.containedWithin = containedWithin
    }
  }
}

extension Sweet.PlaceModel: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Sweet.PlaceField.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.fullName = try container.decode(String.self, forKey: .fullName)
    self.name = try container.decodeIfPresent(String.self, forKey: .name)
    self.country = try container.decodeIfPresent(String.self, forKey: .country)
    self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
    self.geo = try container.decodeIfPresent(Sweet.GeoModel.self, forKey: .geo)

    let type = try container.decodeIfPresent(String.self, forKey: .placeType)
    self.type = type.map { Sweet.PlaceType(rawValue: $0)! }

    let containedWithin = try container.decodeIfPresent([String].self, forKey: .containedWithin)
    self.containedWithin = containedWithin ?? []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.PlaceField.self)
    try container.encode(id, forKey: .id)
    try container.encode(fullName, forKey: .fullName)
    try container.encodeIfPresent(name, forKey: .name)
    try container.encodeIfPresent(country, forKey: .country)
    try container.encodeIfPresent(countryCode, forKey: .countryCode)
    try container.encodeIfPresent(geo, forKey: .geo)
    try container.encodeIfPresent(type?.rawValue, forKey: .placeType)
    try container.encodeIfPresent(containedWithin, forKey: .containedWithin)
  }
}
