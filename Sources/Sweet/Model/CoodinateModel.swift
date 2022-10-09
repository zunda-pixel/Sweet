//
//  CoordinateModel.swift
//

import Foundation

extension Sweet {
  public struct CoordinateModel: Hashable, Sendable {
    public let type: String
    public let latitude: Double
    public let longitude: Double
    
    public init(type: String, latitude: Double, longitude: Double) {
      self.type = type
      self.latitude = latitude
      self.longitude = longitude
    }
  }
}

extension Sweet.CoordinateModel: Codable {
  private enum CodingKeys: CodingKey {
    case type
    case coordinates
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.type = try container.decode(String.self, forKey: .type)
    
    let coordinates = try container.decode([Double].self, forKey: .coordinates)
    self.latitude = coordinates[0]
    self.longitude = coordinates[1]
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(type, forKey: .type)
    try container.encode([latitude, longitude], forKey: .coordinates)
  }
}
