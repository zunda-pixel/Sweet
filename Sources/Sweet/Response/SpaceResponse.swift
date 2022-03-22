//
//  SpacesResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  internal struct SpacesResponse {
    public let spaces: [SpaceModel]
  }
}

extension Sweet.SpacesResponse: Decodable {
   private enum CodingKeys: String, CodingKey {
     case spaces = "data"
  }
}

extension Sweet {
  internal struct SpaceResponse {
    public var space: SpaceModel
  }
}

extension Sweet.SpaceResponse: Decodable {
   private enum CodingKeys: String, CodingKey {
     case space = "data"
     case includes
  }
  
  private enum UserCodingKeys: String, CodingKey {
    case users
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.space = try values.decode(Sweet.SpaceModel.self, forKey: .space)
    
    guard let includes = try? values.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .includes) else {
      return
    }
    
    let users = try? includes.decode([Sweet.UserModel].self, forKey: .users)
    self.space.users = users ?? []
  }
}
