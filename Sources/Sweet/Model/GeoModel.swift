//
//  GeoModel.swift
//

import Foundation

extension Sweet {
  /// Geo Model
  public struct GeoModel: Sendable, Hashable {
    public let type: GeoType
    public let bbox: [Double]
    
    public init(type: GeoType, bbox: [Double] = []) {
      self.type = type
      self.bbox = bbox
    }
  }
}

extension Sweet.GeoModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case type
    case bbox
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(String.self, forKey: .type)
    self.type = .init(rawValue: type)!
    
    self.bbox = try container.decode([Double].self, forKey: .bbox)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type.rawValue, forKey: .type)
    
    try container.encode(bbox, forKey: .bbox)
  }
}

