//
//  CoordinatesModel.swift
//

import Foundation

extension Sweet {
  public struct CoordinatesModel: Hashable, Sendable, Codable {
    public let type: String
    public let coordinates: [Double]
    
    public init(type: String, coordinates: [Double]) {
      self.type = type
      self.coordinates = coordinates
    }
  }
}
