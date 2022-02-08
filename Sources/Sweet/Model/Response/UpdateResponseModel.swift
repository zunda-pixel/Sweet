//
//  UpdateResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct UpdateResponseModel: Decodable {
  public let updated: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case updated
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.updated = try usersInfo.decode(Bool.self, forKey: .updated)
  }
}