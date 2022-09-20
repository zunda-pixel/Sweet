//
//  ListResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// List Response
  public struct ListResponse: Sendable {
    public let list: ListModel
    public let users: [UserModel]
  }
}

extension Sweet.ListResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case list = "data"
    case includes
  }
  
  private enum UserIncludesCodingKeys: String, CodingKey {
    case users
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.list = try values.decode(Sweet.ListModel.self, forKey: .list)
    
    guard let includes = try? values.nestedContainer(keyedBy: UserIncludesCodingKeys.self, forKey: .includes) else {
      self.users = []
      return
    }
    
    let users = try? includes.decode([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}

extension Sweet {
  /// Lists Response
  public struct ListsResponse: Sendable {
    public let lists: [ListModel]
    public let meta: MetaModel
    public let users: [UserModel]
  }
}

extension Sweet.ListsResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case lists = "data"
    case meta
    case includes
  }
  
  private enum UserIncludesCodingKeys: String, CodingKey {
    case users
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.meta = try values.decode(Sweet.MetaModel.self, forKey: .meta)
    
    if meta.resultCount == 0 {
      self.lists = []
      self.users = []
      return
    }
    
    self.lists = try values.decode([Sweet.ListModel].self, forKey: .lists)
    
    guard let includes = try? values.nestedContainer(keyedBy: UserIncludesCodingKeys.self, forKey: .includes) else {
      self.users = []
      return
    }
    
    let users = try? includes.decode([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}
