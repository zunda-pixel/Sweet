//
//  SpacesResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct SpacesResponseModel {
  public let spaces: [SpaceModel]
}

extension SpacesResponseModel: Decodable {
   private enum CodingKeys: String, CodingKey {
    case spaces = "data"
  }
}

public struct SpaceResponseModel {
  public let space: SpaceModel
}

extension SpaceResponseModel: Decodable {
   private enum CodingKeys: String, CodingKey {
    case space = "data"
  }
}
