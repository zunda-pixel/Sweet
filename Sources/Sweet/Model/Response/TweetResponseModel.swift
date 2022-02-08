//
//  TweetResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct TweetsResponseModel: Decodable {
  public var tweets: [TweetModel]
  
  private enum CodingKeys: String, CodingKey {
    case tweets = "data"
    case includes
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.tweets = try values.decode([TweetModel].self, forKey: .tweets)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetIncludesCodingKeys.self, forKey: .includes) else {
      return
    }
    
    if let medias = try? includes.decode([MediaModel].self, forKey: .media) {
      for media in medias {
        if let index = self.tweets.firstIndex(where: { $0.attachments?.mediaKeys?.contains(media.key) ?? false }) {
          self.tweets[index].medias.append(media)
        }
      }
    }
  
    if let users = try? includes.decode([UserModel].self, forKey: .users) {
      for i in 0..<self.tweets.count {
        let user = users.first { $0.id == tweets[i].authorID }
        tweets[i].user = user
      }
    }
    
    if let places = try? includes.decode([PlaceModel].self, forKey: .places) {
      for i in 0..<self.tweets.count {
        if let placeID = tweets[i].geo?.placeID {
          let place = places.first { $0.id == placeID }
          tweets[i].place = place
        }
      }
    }
    
    
    if let polls = try? includes.decode([PollModel].self, forKey: .polls) {
      for i in 0..<self.tweets.count {
        if let pollID = tweets[i].attachments?.pollID {
          let poll = polls.first { $0.id == pollID }
          tweets[i].poll = poll
        }
      }
    }
  }
}

private enum TweetIncludesCodingKeys: String, CodingKey {
  case media
  case users
  case places
  case polls
}

struct TweetResponseModel: Decodable {
  public var tweet: TweetModel
  
  private enum CodingKeys: String, CodingKey {
    case tweet = "data"
    case includes
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.tweet = try values.decode(TweetModel.self, forKey: .tweet)
    
    guard let includes = try? values.nestedContainer(keyedBy: TweetIncludesCodingKeys.self, forKey: .includes) else {
      return
    }
    
    let medias = try? includes.decode([MediaModel].self, forKey: .media)
    self.tweet.medias = medias ?? []
    
    if let users = try? includes.decode([UserModel].self, forKey: .users) {
      self.tweet.user = users.first!
    }
    
    if let places = try? includes.decode([PlaceModel].self, forKey: .places) {
      self.tweet.place = places.first
    }
    
    let polls = try? includes.decode([PollModel].self, forKey: .polls)
    
    if let pollID = self.tweet.attachments?.pollID {
      self.tweet.poll = polls?.first { $0.id == pollID }
    }
  }
}
