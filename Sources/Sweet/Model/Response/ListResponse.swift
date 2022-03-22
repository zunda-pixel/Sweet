//
//  ListResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  internal struct ListResponse {
    public var list: ListModel
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
    
    self.list = try values.decode(ListModel.self, forKey: .list)
    
    guard let includes = try? values.nestedContainer(keyedBy: UserIncludesCodingKeys.self, forKey: .includes) else {
      return
    }
    
    let users = try? includes.decode([UserModel].self, forKey: .users)
    
    self.list.users = users ?? []
  }
}

extension Sweet {
  internal struct ListsResponse {
    public let lists: [ListModel]
    public let meta: MetaModel
  }
}


extension Sweet.ListsResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case lists = "data"
    case meta
  }
}
