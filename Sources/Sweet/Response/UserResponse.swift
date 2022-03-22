//
//  UserResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct UserResponse {
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
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.user = try values.decode(Sweet.UserModel.self, forKey: .user)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetCodingKeys.self, forKey: .includes) else {
      self.tweets = []
      return
    }
    
    let tweets = try? includes.decode([Sweet.TweetModel].self, forKey: .tweets)
    self.tweets = tweets ?? []
  }
}

extension Sweet {
  public struct UsersResponse {
    public var users: [UserModel]
    public let meta: MetaModel?
    public let tweets: [TweetModel]
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
      self.tweets = []
      return
    }
    
    self.users = try values.decode([Sweet.UserModel].self, forKey: .users)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetCodingKeys.self, forKey: .includes) else {
      self.tweets = []
      return
    }
    
    let tweets = try? includes.decode([Sweet.TweetModel].self, forKey: .tweets)
    self.tweets = tweets ?? []
  }
}
