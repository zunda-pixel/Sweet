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

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let pinContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.pinned = try pinContainer.decode(Bool.self, forKey: .pinned)
  }
}
