//
//  LikeResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Like Response
  struct LikeResponse: Sendable {
    public let liked: Bool
  }
}

extension Sweet.LikeResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case liked
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let likeContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.liked = try likeContainer.decode(Bool.self, forKey: .liked)
  }
}
