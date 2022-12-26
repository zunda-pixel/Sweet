//
//  GeoModel.swift
//

import Foundation

extension Sweet {
  /// Geo Model
  public struct GeoModel: Sendable, Hashable {
    public let type: GeoType
    public let boundingBox: [Double]

    public init(type: GeoType, boundingBox: [Double] = []) {
      self.type = type
      self.boundingBox = boundingBox
    }
  }
}

extension Sweet.GeoModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case type
    case boundingBox = "bbox"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(String.self, forKey: .type)
    self.type = Sweet.GeoType(rawValue: type)!

    self.boundingBox = try container.decode([Double].self, forKey: .boundingBox)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type.rawValue, forKey: .type)

    try container.encode(boundingBox, forKey: .boundingBox)
  }
}
