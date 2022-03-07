//
//  UnFollowResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct UnFollowResponseModel: Decodable {
  public let following: Bool
  
  public init(following: Bool) {
    self.following = following
  }
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case following
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.following = try usersInfo.decode(Bool.self, forKey: .following)
  }
}
