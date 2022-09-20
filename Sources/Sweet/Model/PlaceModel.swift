//
//  PlaceModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Place Model
  public struct PlaceModel: Hashable, Identifiable, Sendable {
    public let id: String
    public let name: String

    public init(id: String, name: String) {
      self.id = id
      self.name = name
    }
  }
}

extension Sweet.PlaceModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case name = "full_name"
    case id
  }
}
