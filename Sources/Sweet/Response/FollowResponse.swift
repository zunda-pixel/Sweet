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

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.following = try usersInfo.decode(Bool.self, forKey: .following)
    self.pendingFollow = try usersInfo.decode(Bool.self, forKey: .pendingFollow)
  }
}
