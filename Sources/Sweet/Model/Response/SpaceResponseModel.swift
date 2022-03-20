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
  public var space: SpaceModel
}

extension SpaceResponseModel: Decodable {
   private enum CodingKeys: String, CodingKey {
     case space = "data"
     case includes
  }
  
  private enum UserCodingKeys: String, CodingKey {
    case users
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.space = try values.decode(SpaceModel.self, forKey: .space)
    
    guard let includes = try? values.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .includes) else {
      return
    }
    
    let users = try? includes.decode([UserModel].self, forKey: .users)
    self.space.users = users ?? []
  }
}
