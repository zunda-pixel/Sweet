//
//  RetweetResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Retweet Response
  struct RetweetResponse: Sendable {
    public let retweeted: Bool
  }
}

extension Sweet.RetweetResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case retweeted
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let retweetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.retweeted = try retweetContainer.decode(Bool.self, forKey: .retweeted)
  }
}
