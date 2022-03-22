//
//  TweetResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct TweetsResponse {
    public let tweets: [TweetModel]
    public let meta: MetaModel?
    public let users: [UserModel]
    public let medias: [MediaModel]
    public let places: [PlaceModel]
    public let polls: [PollModel]
  }
}

extension Sweet.TweetsResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case tweets = "data"
    case includes
    case meta
  }
  
  private enum TweetIncludesCodingKeys: String, CodingKey {
    case media
    case users
    case places
    case polls
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.meta = try? values.decode(Sweet.MetaModel.self, forKey: .meta)
    
    if meta?.resultCount == 0 {
      self.tweets = []
      self.medias = []
      self.users = []
      self.places = []
      self.polls = []
      return
    }
    
    self.tweets = try values.decode([Sweet.TweetModel].self, forKey: .tweets)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetIncludesCodingKeys.self, forKey: .includes) else {
      self.medias = []
      self.users = []
      self.places = []
      self.polls = []
      return
    }
    
    
    let medias = try? includes.decode([Sweet.MediaModel].self, forKey: .media)
    self.medias = medias ?? []
  
    
    let users = try? includes.decode([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
    
    let places = try? includes.decode([Sweet.PlaceModel].self, forKey: .places)
    self.places = places ?? []
    
    let polls = try? includes.decode([Sweet.PollModel].self, forKey: .polls)
    self.polls = polls ?? []
  }
}

extension Sweet {
  public struct TweetResponse {
    public let tweet: TweetModel
    public let users: [UserModel]
    public let medias: [MediaModel]
    public let places: [PlaceModel]
    public let polls: [PollModel]
  }
}

extension Sweet.TweetResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case tweet = "data"
    case includes
  }
  
  private enum TweetIncludesCodingKeys: String, CodingKey {
    case media
    case users
    case places
    case polls
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
        
    self.tweet = try values.decode(Sweet.TweetModel.self, forKey: .tweet)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetIncludesCodingKeys.self, forKey: .includes) else {
      self.medias = []
      self.users = []
      self.places = []
      self.polls = []
      return
    }
    
    let medias = try? includes.decode([Sweet.MediaModel].self, forKey: .media)
    self.medias = medias ?? []
    
    let users = try? includes.decode([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
    
    let places = try? includes.decode([Sweet.PlaceModel].self, forKey: .places)
    self.places = places ?? []
    
    let polls = try? includes.decode([Sweet.PollModel].self, forKey: .polls)
    self.polls = polls ?? []
  }
}
