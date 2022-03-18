//
//  PlaceModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct PlaceModel {
  public let name: String
  public let id: String
}

extension PlaceModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case name = "full_name"
    case id
  }
}
