//
//  TweetResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Tweets Response
  public struct TweetsResponse: Sendable {
    public let tweets: [TweetModel]
    public let meta: MetaModel?
    public let users: [UserModel]
    public let medias: [MediaModel]
    public let places: [PlaceModel]
    public let polls: [PollModel]
    public let relatedTweets: [TweetModel]
    public let errors: [ResourceError]
  }
}

extension Sweet.TweetsResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case tweets = "data"
    case includes
    case meta
    case errors
  }

  private enum TweetIncludesCodingKeys: String, CodingKey {
    case media
    case users
    case places
    case polls
    case tweets
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let errors = try container.decodeIfPresent([Sweet.ErrorMessageModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []

    self.meta = try container.decodeIfPresent(Sweet.MetaModel.self, forKey: .meta)

    if meta?.resultCount == 0 {
      self.tweets = []
      self.medias = []
      self.users = []
      self.places = []
      self.polls = []
      self.relatedTweets = []
      return
    }

    self.tweets = try container.decode([Sweet.TweetModel].self, forKey: .tweets)

    let includeContainer = try? container.nestedContainer(
      keyedBy: TweetIncludesCodingKeys.self,
      forKey: .includes
    )

    let medias = try includeContainer?.decodeIfPresent([Sweet.MediaModel].self, forKey: .media)
    self.medias = medias ?? []

    let users = try includeContainer?.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []

    let places = try includeContainer?.decodeIfPresent([Sweet.PlaceModel].self, forKey: .places)
    self.places = places ?? []

    let polls = try includeContainer?.decodeIfPresent([Sweet.PollModel].self, forKey: .polls)
    self.polls = polls ?? []

    let relatedTweets = try includeContainer?.decodeIfPresent(
      [Sweet.TweetModel].self, forKey: .tweets)
    self.relatedTweets = relatedTweets ?? []
  }
}

extension Sweet {
  /// Tweet Response
  public struct TweetResponse: Sendable {
    public let tweet: TweetModel
    public let users: [UserModel]
    public let medias: [MediaModel]
    public let places: [PlaceModel]
    public let polls: [PollModel]
    public let relatedTweets: [TweetModel]
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
    case tweets
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.tweet = try container.decode(Sweet.TweetModel.self, forKey: .tweet)

    let includeContainer = try? container.nestedContainer(
      keyedBy: TweetIncludesCodingKeys.self,
      forKey: .includes
    )

    let medias = try includeContainer?.decodeIfPresent([Sweet.MediaModel].self, forKey: .media)
    self.medias = medias ?? []

    let users = try includeContainer?.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []

    let places = try includeContainer?.decodeIfPresent([Sweet.PlaceModel].self, forKey: .places)
    self.places = places ?? []

    let polls = try includeContainer?.decodeIfPresent([Sweet.PollModel].self, forKey: .polls)
    self.polls = polls ?? []

    let relatedTweets = try includeContainer?.decodeIfPresent(
      [Sweet.TweetModel].self, forKey: .tweets)
    self.relatedTweets = relatedTweets ?? []
  }
}
