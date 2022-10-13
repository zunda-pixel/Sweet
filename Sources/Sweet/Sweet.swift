//
//  Sweet.swift
//
//
//  Created by zunda on 2022/01/14.
//

/// Sweet for Twitter API v2

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

public struct Sweet: Sendable {
  public let bearerTokenApp: String
  public let bearerTokenUser: String

  public let session: URLSession

  public var authorizeType: AuthorizeType = .user

  public var tweetExpansions: [TweetExpansion] = TweetExpansion.allCases
  public var userExpansions: [UserExpansion] = UserExpansion.allCases
  public var mediaExpansions: [MediaExpansion] = MediaExpansion.allCases
  public var pollExpansions: [PollExpansion] = PollExpansion.allCases
  public var placeExpansions: [PlaceExpansion] = PlaceExpansion.allCases

  public var tweetFields: [TweetField] = TweetField.allCases
  public var userFields: [UserField] = UserField.allCases
  public var mediaFields: [MediaField] = MediaField.allCases
  public var pollFields: [PollField] = PollField.allCases
  public var placeFields: [PlaceField] = PlaceField.allCases
  public var listFields: [ListField] = ListField.allCases
  public var topicFields: [TopicField] = TopicField.allCases
  public var spaceFields: [SpaceField] = SpaceField.allCases

  public init(app bearerTokenApp: String, user bearerTokenUser: String, session: URLSession) {
    self.bearerTokenApp = bearerTokenApp
    self.bearerTokenUser = bearerTokenUser

    self.session = session
  }
}
