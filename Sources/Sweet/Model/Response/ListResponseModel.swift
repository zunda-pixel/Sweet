//
//  ListResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation


public struct ListResponseModel {
  public let list: ListModel
}

extension ListResponseModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case list = "data"
  }
}

struct ListsResponseModel {
  public let lists: [ListModel]
}

extension ListsResponseModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case lists = "data"
  }
}
