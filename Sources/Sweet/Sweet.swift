//
//  Sweet.swift
//

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/// Sweet for Twitter API v2
public struct Sweet: Sendable {
  public let token: AuthorizationType
  public let config: URLSessionConfiguration

  var session: URLSession { .init(configuration: config) }

  public var tweetExpansions: [TweetExpansion] = TweetExpansion.allCases
  public var userExpansions: [UserExpansion] = UserExpansion.allCases
  public var mediaExpansions: [MediaExpansion] = MediaExpansion.allCases
  public var pollExpansions: [PollExpansion] = PollExpansion.allCases
  public var placeExpansions: [PlaceExpansion] = PlaceExpansion.allCases
  public var directMesssageExpansions: [DirectMessageExpansion] = DirectMessageExpansion.allCases
  public var listExpansions: [ListExpansion] = ListExpansion.allCases
  public var spaceExpansions: [SpaceExpansion] = SpaceExpansion.allCases

  public var tweetFields: [TweetField] = TweetField.allCases
  public var userFields: [UserField] = UserField.allCases
  public var mediaFields: [MediaField] = MediaField.allCases
  public var pollFields: [PollField] = PollField.allCases
  public var placeFields: [PlaceField] = PlaceField.allCases
  public var listFields: [ListField] = ListField.allCases
  public var topicFields: [TopicField] = TopicField.allCases
  public var spaceFields: [SpaceField] = SpaceField.allCases
  public var directMessageFields: [DirectMessageField] = DirectMessageField.allCases

  public init(token: AuthorizationType, config: URLSessionConfiguration) {
    self.token = token
    self.config = config
  }
}

extension Sweet {
  var allTweetExpansion: [String] {
    let allExpansions: [String] =
      tweetExpansions.map(\.rawValue) + pollExpansions.map(\.rawValue)
      + mediaExpansions.map(\.rawValue) + placeExpansions.map(\.rawValue)
    return allExpansions
  }

  var allUserExpansion: [String] {
    let allExpansions: [String] = userExpansions.map(\.rawValue)
    return allExpansions
  }

  var allDirectMessageExpansion: [String] {
    let allExpansions: [String] =
      directMesssageExpansions.map(\.rawValue) + mediaExpansions.map(\.rawValue)
    return allExpansions
  }

  var allListExpansion: [String] {
    let allExpansions: [String] = listExpansions.map(\.rawValue)
    return allExpansions
  }

  var allSpaceExpansion: [String] {
    let allExpansions: [String] = spaceExpansions.map(\.rawValue)
    return allExpansions
  }
}
