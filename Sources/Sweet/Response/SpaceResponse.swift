//
//  SpacesResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Spaces Response
  public struct SpacesResponse {
    public let spaces: [SpaceModel]
    public let users: [UserModel]
  }
}

extension Sweet.SpacesResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case spaces = "data"
    case includes
  }
  private enum UserCodingKeys: String, CodingKey {
    case users
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.spaces = try values.decode([Sweet.SpaceModel].self, forKey: .spaces)
    
    guard let includes = try? values.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .includes) else {
      self.users = []
      return
    }
    
    let users = try? includes.decode([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}

extension Sweet {
  public struct SpaceResponse {
    public var space: SpaceModel
    public let users: [UserModel]
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
      self.users = []
      return
    }
    
    let users = try? includes.decode([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}
