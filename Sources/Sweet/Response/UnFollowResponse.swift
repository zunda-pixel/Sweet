//
//  UnFollowResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Un Follow Response
  struct UnFollowResponse: Sendable {
    public let following: Bool
  }
}

extension Sweet.UnFollowResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case following
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let followContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.following = try followContainer.decode(Bool.self, forKey: .following)
  }
}
