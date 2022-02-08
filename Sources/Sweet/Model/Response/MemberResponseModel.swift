//
//  MemberResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

struct MemberResponseModel: Decodable {
  public let isMember: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case isMember = "is_member"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.isMember = try usersInfo.decode(Bool.self, forKey: .isMember)
  }
}
