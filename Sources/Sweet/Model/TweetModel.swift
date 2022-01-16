//
//  TweetModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

struct TweetModel: Decodable {
  let id: String
  let text: String
}

struct TweetsResponseModel: Decodable {
  let tweets: [TweetModel]
  
  private enum CodingKeys: String, CodingKey {
    case tweets = "data"
  }
}

struct TweetResponseModel: Decodable {
  let tweet: TweetModel
  
  private enum CodingKeys: String, CodingKey {
    case tweet = "data"
  }
}

struct DeleteTweetResponseModel: Decodable {
  let deleted: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case deleted
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.deleted = try usersInfo.decode(Bool.self, forKey: .deleted)
  }
}

struct CountTweetModel: Decodable {
  let countTweet: Int
  let startDate: Date
  let endDate: Date
  
  private enum CodingKeys: String, CodingKey {
    case countTweet = "tweet_count"
    case startDate = "start"
    case endDate = "end"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.countTweet = try values.decode(Int.self, forKey: .countTweet)
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
    let startDateString = try values.decode(String.self, forKey: .startDate)
    let endDateString = try values.decode(String.self, forKey: .endDate)
    
    self.startDate = formatter.date(from: startDateString)!
    self.endDate = formatter.date(from: endDateString)!
  }
}

struct CountTweetResponseModel: Decodable {
  let countTweetModels : [CountTweetModel]
  
  private enum CodingKeys: String, CodingKey {
    case countTweetModels = "data"
  }
}

struct StreamRuleModel: Codable {
  let id: String
  let value: String
  let tag: String?
  
  init(value: String, tag: String? = nil) {
    self.id = ""
    self.tag = tag
    self.value = value
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value, forKey: .value)
    if let tag = tag {
        try container.encode(tag, forKey: .tag)
    }
  }
}

struct StreamRuleResponseModel: Decodable {
  let streamRules: [StreamRuleModel]
  
  private enum CodingKeys: String, CodingKey {
    case streamRules = "data"
  }
}

struct RetweetResponseModel: Decodable {
  let retweeted: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case retweeted
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let retweetedInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.retweeted = try retweetedInfo.decode(Bool.self, forKey: .retweeted)
  }
}

struct LikeResponseModel: Decodable {
  let liked: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case liked
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let retweetedInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.liked = try retweetedInfo.decode(Bool.self, forKey: .liked)
  }
}

struct HideResponseModel: Decodable {
  let hidden: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case hidden
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let hideInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.hidden = try hideInfo.decode(Bool.self, forKey: .hidden)
  }
}
