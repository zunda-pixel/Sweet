//
//  UserModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

public struct UserModel: Decodable {
  let name: String
  let id: String
  let username: String
}

struct UserResponseModel: Decodable {
  let user: UserModel
  private enum CodingKeys: String, CodingKey {
    case user = "data"
  }
}

struct UsersResponseModel: Decodable {
  let users: [UserModel]
  private enum CodingKeys: String, CodingKey {
    case users = "data"
  }
}

struct UnFollowResponseModel: Decodable {
  let following: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case following
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.following = try usersInfo.decode(Bool.self, forKey: .following)
  }
}

struct FollowResponseModel: Decodable {
  let following: Bool
  let pendingFollow: Bool

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

struct BlockResponseModel: Decodable {
  let blocking: Bool

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

struct MuteResponseModel: Decodable {
  let muting: Bool

  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case muting
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.muting = try usersInfo.decode(Bool.self, forKey: .muting)
  }
}
