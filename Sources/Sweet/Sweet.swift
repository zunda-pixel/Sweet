//
//  Sweet.swift
//

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/// Sweet for Twitter API v2
public struct Sweet: Sendable {
  public let bearerTokenApp: String
  public let bearerTokenUser: String

  public let config: URLSessionConfiguration

  var session: URLSession { .init(configuration: config) }

  public var authorizeType: AuthorizeType = .user

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

  public init(
    app bearerTokenApp: String, user bearerTokenUser: String, config: URLSessionConfiguration
  ) {
    self.bearerTokenApp = bearerTokenApp
    self.bearerTokenUser = bearerTokenUser

    self.config = config
  }
}
