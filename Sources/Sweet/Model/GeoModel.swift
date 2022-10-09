//
//  GeoModel.swift
//

import Foundation

extension Sweet {
  /// Geo Model
  public struct GeoModel: Sendable, Hashable {
    public let type: String
    public let bbox: [Double]
    
    public init(type: String, bbox: [Double] = []) {
      self.type = type
      self.bbox = bbox
    }
  }
}

extension Sweet.GeoModel: Codable {
  
}

