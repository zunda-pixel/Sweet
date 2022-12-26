//
//  UserResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// User Response
  public struct UserResponse: Sendable {
    public let user: UserModel
    public let tweets: [TweetModel]
  }
}

extension Sweet.UserResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case user = "data"
    case includes
  }

  private enum TweetCodingKeys: String, CodingKey {
    case tweets
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.user = try container.decode(Sweet.UserModel.self, forKey: .user)

    let includeContainer = try? container.nestedContainer(
      keyedBy: TweetCodingKeys.self, forKey: .includes)

    let tweets = try includeContainer?.decodeIfPresent([Sweet.TweetModel].self, forKey: .tweets)
    self.tweets = tweets ?? []
  }
}

extension Sweet {
  /// Users Response
  public struct UsersResponse: Sendable {
    public var users: [UserModel]
    public let meta: MetaModel?
    public let tweets: [TweetModel]
    public let errors: [ResourceError]
  }
}

extension Sweet.UsersResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case users = "data"
    case errors
    case meta
    case includes
  }

  private enum TweetCodingKeys: String, CodingKey {
    case tweets
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let errors = try container.decodeIfPresent([Sweet.ErrorMessageModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []

    self.meta = try container.decodeIfPresent(Sweet.MetaModel.self, forKey: .meta)

    if meta?.resultCount == 0 {
      self.users = []
      self.tweets = []
      return
    }

    self.users = try container.decode([Sweet.UserModel].self, forKey: .users)

    let nestedContainer = try? container.nestedContainer(
      keyedBy: TweetCodingKeys.self, forKey: .includes)

    let tweets = try nestedContainer?.decodeIfPresent([Sweet.TweetModel].self, forKey: .tweets)
    self.tweets = tweets ?? []
  }
}
