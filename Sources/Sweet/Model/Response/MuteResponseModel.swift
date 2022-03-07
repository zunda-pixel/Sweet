//
//  MuteResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct MuteResponseModel: Decodable {
  public let muting: Bool

  public init(muting: Bool) {
    self.muting = muting
  }
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case muting
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.muting = try usersInfo.decode(Bool.self, forKey: .muting)
  }
}
