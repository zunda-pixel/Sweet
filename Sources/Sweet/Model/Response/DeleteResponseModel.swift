//
//  DeleteResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct DeleteResponseModel: Decodable {
  public let deleted: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case deleted
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.deleted = try usersInfo.decode(Bool.self, forKey: .deleted)
  }
}
