//
//  PinResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Pin Response
  struct PinResponse: Sendable {
    public let pinned: Bool
  }
}

extension Sweet.PinResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case pinned
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.pinned = try usersInfo.decode(Bool.self, forKey: .pinned)
  }
}
