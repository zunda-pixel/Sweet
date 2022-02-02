//
//  TweetModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

public struct TweetModel: Decodable {
  public let id: String
  public let text: String
  public let authorID: String?
  public let lang: String?
  public let replySettings: String?
  public let createdAt: Date?
  public let source: String?
  public let sensitive: Bool?
  public let publicMetrics: PublicMetricsModel?
  public let organicMetrics: OrganicMetricsModel?
  public let privateMetrics: PrivateMetricsModel?
  
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: TweetField.self)
    
    self.id = try value.decode(String.self, forKey: .id)
    self.text = try value.decode(String.self, forKey: .text)
    
    self.authorID = try? value.decode(String.self, forKey: .authorID)
    self.lang = try? value.decode(String.self, forKey: .lang)
    self.replySettings = try? value.decode(String.self, forKey: .replySettings)
    
    if let createdAt = try? value.decode(String.self, forKey: .createdAt) {
      let formatter = ISO8601DateFormatter()
      formatter.formatOptions.insert(.withFractionalSeconds)
      self.createdAt = formatter.date(from: createdAt)!
    } else {
      self.createdAt = nil
    }

    self.source = try? value.decode(String.self, forKey: .source)
    self.sensitive = try? value.decode(Bool.self, forKey: .possiblySensitive)
    self.publicMetrics = try? value.decode(PublicMetricsModel.self, forKey: .publicMetrics)
    self.organicMetrics = try? value.decode(OrganicMetricsModel.self, forKey: .organicMetrics)
    self.privateMetrics = try? value.decode(PrivateMetricsModel.self, forKey: .nonPublicMetrics)
  }
}

public  struct OrganicMetricsModel: Decodable {
  let likeCount: Int
  let userProfilleClicks: Int
  let replyCount: Int
  let impressionCount: Int
  let retweetCount: Int
  
  private enum CodingKeys: String, CodingKey {
    case likeCount = "like_count"
    case userProfilleClicks = "user_profile_clicks"
    case replyCount = "reply_count"
    case impressionCount = "impression_count"
    case retweetCount = "retweet_count"
  }
}

public struct PrivateMetricsModel: Decodable {
  let impressionCount: Int
  let userProfilleClicks: Int
  
  private enum CodingKeys: String, CodingKey {
    case userProfilleClicks = "user_profile_clicks"
    case impressionCount = "impression_count"
  }
}


public struct PublicMetricsModel: Decodable {
  let retweetCount: Int
  let replyCount: Int
  let likeCount: Int
  let quoteCount: Int
  
  private enum CodingKeys: String, CodingKey {
    case retweetCount = "retweet_count"
    case replyCount = "reply_count"
    case likeCount = "like_count"
    case quoteCount = "quote_count"
  }
}



public struct TweetsResponseModel: Decodable {
  public let tweets: [TweetModel]
  
  private enum CodingKeys: String, CodingKey {
    case tweets = "data"
  }
}

struct TweetResponseModel: Decodable {
  public let tweet: TweetModel
  
  private enum CodingKeys: String, CodingKey {
    case tweet = "data"
  }
}

struct DeleteResponseModel: Decodable {
  public let deleted: Bool
  
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

public struct CountTweetModel: Decodable {
  public let countTweet: Int
  public let startDate: Date
  public let endDate: Date
  
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

public struct CountTweetResponseModel: Decodable {
  public let countTweetModels : [CountTweetModel]
  
  private enum CodingKeys: String, CodingKey {
    case countTweetModels = "data"
  }
}

public struct StreamRuleModel: Codable {
  public let id: String
  public let value: String
  public let tag: String?
  
  public init(value: String, tag: String? = nil) {
    self.id = ""
    self.tag = tag
    self.value = value
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value, forKey: .value)
    if let tag = tag {
        try container.encode(tag, forKey: .tag)
    }
  }
}

public struct StreamRuleResponseModel: Decodable {
  public let streamRules: [StreamRuleModel]
  
  private enum CodingKeys: String, CodingKey {
    case streamRules = "data"
  }
}

public struct RetweetResponseModel: Decodable {
  public let retweeted: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case retweeted
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let retweetedInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.retweeted = try retweetedInfo.decode(Bool.self, forKey: .retweeted)
  }
}

public struct LikeResponseModel: Decodable {
  public let liked: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case liked
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let retweetedInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.liked = try retweetedInfo.decode(Bool.self, forKey: .liked)
  }
}

public struct HideResponseModel: Decodable {
  public let hidden: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case hidden
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let hideInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.hidden = try hideInfo.decode(Bool.self, forKey: .hidden)
  }
}
