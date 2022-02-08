//
//  ListResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation


public struct ListResponseModel: Decodable {
  public let list: ListModel

  private enum CodingKeys: String, CodingKey {
    case list = "data"
  }
}

struct ListsResponseModel: Decodable {
  public let lists: [ListModel]

  private enum CodingKeys: String, CodingKey {
    case lists = "data"
  }
}
