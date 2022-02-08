//
//  UserResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

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