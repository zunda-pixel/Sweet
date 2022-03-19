//
//  ListResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation


public struct ListResponseModel {
  public var list: ListModel
}

extension ListResponseModel: Decodable {
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

struct ListsResponseModel {
  public let lists: [ListModel]
  public let meta: MetaModel
}

extension ListsResponseModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case lists = "data"
    case meta
  }
}
