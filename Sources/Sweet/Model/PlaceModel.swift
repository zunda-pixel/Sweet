//
//  PlaceModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct PlaceModel {
    public let name: String
    public let id: String
    
    public init(name: String, id: String) {
      self.name = name
      self.id = id
    }
  }
}

extension Sweet.PlaceModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case name = "full_name"
    case id
  }
}
