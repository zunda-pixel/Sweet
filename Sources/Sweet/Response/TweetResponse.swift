//
//  TweetResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  internal struct TweetsResponse {
    public var tweets: [TweetModel]
    public let meta: MetaModel?
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
      return
    }
    
    self.tweets = try values.decode([Sweet.TweetModel].self, forKey: .tweets)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetIncludesCodingKeys.self, forKey: .includes) else {
      return
    }
    
    if let medias = try? includes.decode([Sweet.MediaModel].self, forKey: .media) {
      for media in medias {
        if let index = self.tweets.firstIndex(where: { $0.attachments?.mediaKeys.contains(media.key) ?? false }) {
          self.tweets[index].medias.append(media)
        }
      }
    }
  
    if let users = try? includes.decode([Sweet.UserModel].self, forKey: .users) {
      for i in 0..<self.tweets.count {
        let user = users.first { $0.id == tweets[i].authorID }
        tweets[i].user = user
      }
    }
    
    if let places = try? includes.decode([Sweet.PlaceModel].self, forKey: .places) {
      for i in 0..<self.tweets.count {
        if let placeID = tweets[i].geo?.placeID {
          let place = places.first { $0.id == placeID }
          tweets[i].place = place
        }
      }
    }
    
    if let polls = try? includes.decode([Sweet.PollModel].self, forKey: .polls) {
      for i in 0..<self.tweets.count {
        if let pollID = tweets[i].attachments?.pollID {
          let poll = polls.first { $0.id == pollID }
          tweets[i].poll = poll
        }
      }
    }
  }
}

extension Sweet {
  internal struct TweetResponse {
    public var tweet: TweetModel
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
      return
    }
    
    let medias = try? includes.decode([Sweet.MediaModel].self, forKey: .media)
    self.tweet.medias = medias ?? []
    
    if let user = try? includes.decode([Sweet.UserModel].self, forKey: .users).first {
      self.tweet.user = user
    }
    
    if let places = try? includes.decode([Sweet.PlaceModel].self, forKey: .places) {
      self.tweet.place = places.first
    }
    
    let polls = try? includes.decode([Sweet.PollModel].self, forKey: .polls)
    
    if let pollID = self.tweet.attachments?.pollID {
      self.tweet.poll = polls?.first { $0.id == pollID }
    }
  }
}
