//
//  GeoModel.swift
//

import Foundation

extension Sweet {
  /// Geo Model
  public struct GeoModel: Sendable, Hashable {
    public let type: String
    public let bbox: [String]
    public let properties: [String]
    
    public init(type: String, bbox: [String] = [], properties: [String] = []) {
      self.type = type
      self.bbox = bbox
      self.properties = properties
    }
  }
}

extension Sweet.GeoModel: Codable {
  
}

