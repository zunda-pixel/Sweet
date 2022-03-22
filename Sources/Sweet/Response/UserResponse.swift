//
//  UserResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  internal struct UserResponse {
    public var user: UserModel
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
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.user = try values.decode(Sweet.UserModel.self, forKey: .user)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetCodingKeys.self, forKey: .includes) else {
      return
    }
    
    let tweets = try includes.decode([Sweet.PinTweetModel].self, forKey: .tweets)
    
    if let index = tweets.firstIndex(where: { $0.id == user.pinnedTweetID }) {
      user.pinnedTweet = tweets[index]
    }
  }
}

extension Sweet {
  internal struct UsersResponse {
    public var users: [UserModel]
    public let meta: MetaModel?
  }
}

extension Sweet.UsersResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case users = "data"
    case meta
    case includes
  }
  
  private enum TweetCodingKeys: String, CodingKey {
    case tweets
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.meta = try? values.decode(Sweet.MetaModel.self, forKey: .meta)
    
    if meta?.resultCount == 0 {
      self.users = []
      return
    }
    
    self.users = try values.decode([Sweet.UserModel].self, forKey: .users)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetCodingKeys.self, forKey: .includes) else {
      return
    }
    
    let tweets = try includes.decode([Sweet.PinTweetModel].self, forKey: .tweets)
    
    tweets.forEach { tweet in
      if let index = users.firstIndex(where: { user in user.pinnedTweetID == tweet.id }) {
        self.users[index].pinnedTweet = tweet
      }
    }
  }
}
