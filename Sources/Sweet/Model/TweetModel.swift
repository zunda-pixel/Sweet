//
//  TweetModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

public struct PinTweetModel: Decodable {
  public let id: String
  public let text: String
}

public struct TweetModel: Decodable {
  public let id: String
  public let text: String
  public let authorID: String?
  public let lang: String?
  public let replySettings: String?
  public let createdAt: Date?
  public let source: String?
  public let sensitive: Bool?
  public let geo: GeoModel?
  public let publicMetrics: TweetPublicMetricsModel?
  public let organicMetrics: OrganicMetricsModel?
  public let privateMetrics: PrivateMetricsModel?
  public let attachments: AttachmentsModel?

  public var medias: [MediaModel] = []
  public var user: UserModel!
  public var place: PlaceModel?
  public var poll: PollModel?
  
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
    
    self.geo = try? value.decode(GeoModel.self, forKey: .geo)
    
    self.publicMetrics = try? value.decode(TweetPublicMetricsModel.self, forKey: .publicMetrics)
    self.organicMetrics = try? value.decode(OrganicMetricsModel.self, forKey: .organicMetrics)
    self.privateMetrics = try? value.decode(PrivateMetricsModel.self, forKey: .nonPublicMetrics)
    self.attachments = try? value.decode(AttachmentsModel.self, forKey: .attachments)
  }
}

public struct AttachmentsModel: Decodable {
  let mediaKeys: [String]?
  let pollID: String?
  
  private enum CodingKeys: String, CodingKey {
    case mediaKeys = "media_keys"
    case pollIDs = "poll_ids"
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    self.mediaKeys = try value.decode([String].self, forKey: .mediaKeys)
    
    let pollIDs = try? value.decode([String].self, forKey: .pollIDs)
    self.pollID = pollIDs?.first
  }
}

public struct PollItem: Decodable {
    let position: Int
    let label: String
    let votes: Int
}
                    
public enum PollStatus: String {
  case isOpen = "open"
  case isClosed = "closed"
}
                    
public struct PollModel: Decodable {
  let id: String
  let votingStatus: PollStatus
  let endDatetime: Date
  let durationMinutes: Int
  let options: [PollItem]
  
  private enum CodingKeys: String, CodingKey {
    case id
    case vodingStatus = "voting_status"
    case endDateTime = "end_datetime"
    case durationMinutes = "duration_minutes"
    case options
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try value.decode(String.self, forKey: .id)
    
    let votingStatus = try value.decode(String.self, forKey: .vodingStatus)
    self.votingStatus = .init(rawValue: votingStatus)!
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    let endDateTime = try value.decode(String.self, forKey: .endDateTime)
    self.endDatetime = formatter.date(from: endDateTime)!
    
    self.durationMinutes = try value.decode(Int.self, forKey: .durationMinutes)
    
    self.options = try value.decode([PollItem].self, forKey: .options)
  }
}
                    

public enum Includes: String, CodingKey {
  case includes
}

public enum IncludesData: String, CodingKey {
  case media
  case users
}

public enum MediaType: String {
  case animatedGig = "animated_gif"
  case photo
  case video
}

public struct MediaModel: Decodable {
  public let key: String
  public let type: MediaType
  public let width: Int
  public let height: Int
  public let previewImageURL: URL?
  public let url: URL?
  
  private enum CodingKeys: String, CodingKey {
    case key = "media_key"
    case type
    case width
    case height
    case previewImageURL = "preview_image_url"
    case url
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    let type = try value.decode(String.self, forKey: .type)
    self.type = .init(rawValue: type)!
    
    self.key = try value.decode(String.self, forKey: .key)
    self.height = try value.decode(Int.self, forKey: .height)
    self.width = try value.decode(Int.self, forKey: .width)
    
    if let previewImageURL = try? value.decode(String.self, forKey: .previewImageURL) {
      self.previewImageURL = .init(string: previewImageURL)
    } else {
      self.previewImageURL = nil
    }
    
    if let url = try? value.decode(String.self, forKey: .url) {
      self.url = .init(string: url)
    } else {
      self.url = nil
    }
  }
}

public struct PlaceModel: Decodable {
  let name: String
  let id: String
  
  private enum CodingKeys: String, CodingKey {
    case name = "full_name"
    case id
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

public struct UserPublicMetricsModel: Decodable {
  let followersCount: Int
  let followingCount: Int
  let tweetCount: Int
  let listedCount: Int
  
  private enum CodingKeys: String, CodingKey {
    case followersCount = "followers_count"
    case followingCount = "following_count"
    case tweetCount = "tweet_count"
    case listedCount = "listed_count"
  }
}

public struct TweetPublicMetricsModel: Decodable {
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
  public var tweets: [TweetModel]
  
  private enum CodingKeys: String, CodingKey {
    case tweets = "data"
    case includes
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.tweets = try values.decode([TweetModel].self, forKey: .tweets)
    
    guard let includes = try? values.nestedContainer(keyedBy: IncludesCodingKeys.self, forKey: .includes) else {
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

struct TweetResponseModel: Decodable {
  public var tweet: TweetModel
  
  private enum CodingKeys: String, CodingKey {
    case tweet = "data"
    case includes
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.tweet = try values.decode(TweetModel.self, forKey: .tweet)
    
    guard let includes = try? values.nestedContainer(keyedBy: IncludesCodingKeys.self, forKey: .includes) else {
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

private enum IncludesCodingKeys: String, CodingKey {
  case media
  case users
  case places
  case polls
}

public struct DeleteResponseModel: Decodable {
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
