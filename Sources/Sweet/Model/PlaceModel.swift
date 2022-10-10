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
    
    public init(id: String, fullName: String, name: String? = nil, country: String? = nil, countryCode: String?, geo: GeoModel? = nil, type: PlaceType? = nil, containedWithin: [String] = []) {
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
    self.name = try? container.decode(String.self, forKey: .name)
    self.country = try? container.decode(String.self, forKey: .country)
    self.countryCode = try? container.decode(String.self, forKey: .countryCode)
    self.geo = try? container.decode(Sweet.GeoModel.self, forKey: .geo)
    
    if let type = try? container.decode(String.self, forKey: .placeType) {
      self.type = .init(rawValue: type)!
    } else {
      self.type = nil
    }
    
    let containedWithin = try? container.decode([String].self, forKey: .containedWithin)
    self.containedWithin = containedWithin ?? []
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.PlaceField.self)
    try container.encode(id, forKey: .id)
    try container.encode(fullName, forKey: .fullName)
    try container.encode(name, forKey: .name)
    try container.encode(country, forKey: .country)
    try container.encode(countryCode, forKey: .countryCode)
    try container.encode(geo, forKey: .geo)
    try container.encode(type?.rawValue, forKey: .placeType)
    try container.encode(containedWithin, forKey: .containedWithin)
  }
}
