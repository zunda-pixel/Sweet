//
//  SpacesResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct SpacesResponseModel: Decodable {
  public let spaces: [SpaceModel]

   private enum CodingKeys: String, CodingKey {
    case spaces = "data"
  }
}

public struct SpaceResponseModel: Decodable {
  public let space: SpaceModel

   private enum CodingKeys: String, CodingKey {
    case space = "data"
  }
}
