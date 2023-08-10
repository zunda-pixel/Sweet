//
//  FollowResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Follow Response Model
  struct FollowResponseModel: Sendable {
    public let following: Bool
    public let pendingFollow: Bool
  }
}

extension Sweet.FollowResponseModel: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case following
    case pendingFollow = "pending_follow"
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let followContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.following = try followContainer.decode(Bool.self, forKey: .following)
    self.pendingFollow = try followContainer.decode(Bool.self, forKey: .pendingFollow)
  }
}
