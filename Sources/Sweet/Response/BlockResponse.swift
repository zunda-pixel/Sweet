//
//  BlockResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Block Response
  struct BlockResponse: Sendable {
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
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let blockContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.blocking = try blockContainer.decode(Bool.self, forKey: .blocking)
  }
}
