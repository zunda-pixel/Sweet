//
//  UserModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

public struct UserModel: Decodable {
  public let id: String
  public let name: String
  public let username: String
  public let verified: Bool?
  public let profileImageURL: URL?
  public let description: String?
  public let publicMetrics: UserPublicMetricsModel?
  public let protected: Bool?
  public let url: URL?
  public let createdAt: Date?
  public let location: String?
  public let pinnedTweetID: String?
  public var pinnedTweet: PinTweetModel?
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: UserField.self)
    self.id = try values.decode(String.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name)
    self.username = try values.decode(String.self, forKey: .username)
    self.verified = try? values.decode(Bool.self, forKey: .verified)
    self.description = try? values.decode(String.self, forKey: .description)
    self.publicMetrics = try? values.decode(UserPublicMetricsModel.self, forKey: .publicMetrics)
    self.protected = try? values.decode(Bool.self, forKey: .protected)
    self.location = try? values.decode(String.self, forKey: .location)
    self.pinnedTweetID = try? values.decode(String.self, forKey: .pinnedTweetID)
    
    let profileImageURL = try? values.decode(String.self, forKey: .profileImageURL)
    self.profileImageURL = .init(string: profileImageURL ?? "")
    
    let url = try? values.decode(String.self, forKey: .url)
    self.url = URL(string: url ?? "")
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
    let createdAt = try? values.decode(String.self, forKey: .createdAt)
    self.createdAt = formatter.date(from: createdAt ?? "")
  }
}

public struct UserResponseModel: Decodable {
  public var user: UserModel
  
  private enum CodingKeys: String, CodingKey {
    case user = "data"
    case includes
  }
  
  private enum TweetCodingKeys: String, CodingKey {
    case tweets
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.user = try values.decode(UserModel.self, forKey: .user)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetCodingKeys.self, forKey: .includes) else {
      return
    }
    
    let tweets = try includes.decode([PinTweetModel].self, forKey: .tweets)
    
    if let index = tweets.firstIndex(where: { $0.id == user.pinnedTweetID }) {
      user.pinnedTweet = tweets[index]
    }
  }
}

public struct UsersResponseModel: Decodable {
  public var users: [UserModel]
  
  private enum CodingKeys: String, CodingKey {
    case users = "data"
    case includes
  }
  
  private enum TweetCodingKeys: String, CodingKey {
    case tweets
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.users = try values.decode([UserModel].self, forKey: .users)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetCodingKeys.self, forKey: .includes) else {
      return
    }
    
    let tweets = try includes.decode([PinTweetModel].self, forKey: .tweets)
    
    tweets.forEach { tweet in
      if let index = users.firstIndex(where: { user in user.pinnedTweetID == tweet.id }) {
        self.users[index].pinnedTweet = tweet
      }
    }
  }
}

public struct UnFollowResponseModel: Decodable {
  public let following: Bool
  
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

public struct FollowResponseModel: Decodable {
  public let following: Bool
  public let pendingFollow: Bool

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

public struct BlockResponseModel: Decodable {
  public let blocking: Bool

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

public struct MuteResponseModel: Decodable {
  public let muting: Bool

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
