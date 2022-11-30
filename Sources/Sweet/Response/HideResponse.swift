//
//  HideResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Hide Response
  struct HideResponse: Sendable {
    public let hidden: Bool
  }
}

extension Sweet.HideResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case hidden
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let hideContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.hidden = try hideContainer.decode(Bool.self, forKey: .hidden)
  }
}
