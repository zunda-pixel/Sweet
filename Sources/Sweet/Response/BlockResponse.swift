//
//  BlockResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Block Response
  struct BlockResponse {
    public let blocking: Bool
  }
}

extension Sweet.BlockResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case blocking
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.blocking = try usersInfo.decode(Bool.self, forKey: .blocking)
  }
}
