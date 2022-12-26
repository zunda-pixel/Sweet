//
//  TestCodableModel.swift
//
//
//  Created by zunda on 2022/01/15.
//

import XCTest

@testable import Sweet

final class TestCodableModel: XCTestCase {
  func testUserModelCodable() async throws {
    let response = try await Sweet.test.me()

    let data = try JSONEncoder().encode(response.user)

    let userData = try JSONDecoder().decode(Sweet.UserModel.self, from: data)

    XCTAssertEqual(userData, response.user)
  }

  func testTweetModelCodable() async throws {
    let response = try await Sweet.test.tweet(by: "1528605562954727425")

    let data = try JSONEncoder().encode(response.tweet)

    let tweetData = try JSONDecoder().decode(Sweet.TweetModel.self, from: data)

    XCTAssertEqual(tweetData, response.tweet)
  }

  func testUserModelCodableOffline() throws {
    let user: Sweet.UserModel = .init(
      id: "id", name: "name", userName: "userName", verified: true,
      profileImageURL: .init(string: "https://twitter.com")!, description: "description",
      protected: true, url: .init(string: "https://twitter.com")!, createdAt: Date(),
      location: "location", pinnedTweetID: "pinnedTweetID",
      metrics: .init(followersCount: 1, followingCount: 2, tweetCount: 3, listedCount: 4),
      withheld: .init(
        copyright: true, countryCodes: ["countryCode1", "countryCode2"], scope: .user),
      entity: .init(
        urls: [
          .init(
            start: 1, end: 2, url: .init(string: "https://twitter.com")!,
            expandedURL: "https://twitter.com", displayURL: "https://twitter.com",
            unwoundURL: "https://twitter.com",
            images: [
              .init(
                url: .init(string: "https://twitter.com")!, size: .init(width: 100, height: 200))
            ], status: 3, title: "title", description: "description")
        ],
        descriptionURLs: [
          .init(
            start: 3, end: 4, url: .init(string: "https://twitter.com")!,
            expandedURL: "https://twitter.com", displayURL: "https://twitter.com",
            unwoundURL: "https://twitter.com",
            images: [
              .init(url: .init(string: "https://twitter.com")!, size: .init(width: 33, height: 44))
            ], status: 3, title: "title", description: "description")
        ], hashTags: [.init(start: 1, end: 2, tag: "hashTag")],
        mentions: [.init(start: 3, end: 4, userName: "userName")],
        cashTags: [.init(start: 1, end: 2, tag: "cashTag")]))

    let data = try JSONEncoder().encode(user)

    let decodedUser = try JSONDecoder().decode(Sweet.UserModel.self, from: data)

    XCTAssertEqual(user, decodedUser)
  }

  func testTweetModelCodableOffline() throws {
    let tweet: Sweet.TweetModel = .init(
      id: "id",
      text: "text",
      authorID: "authorID",
      lang: "lang",
      replySetting: .following,
      createdAt: Date(),
      source: "source",
      sensitive: true,
      conversationID: "coversationID",
      replyUserID: "replyUserID",
      geo: .init(placeID: "01a9a39529b27f36", coordinates: .init(type: "", coordinates: [])),
      publicMetrics: .init(retweetCount: 1, replyCount: 2, likeCount: 3, quoteCount: 4),
      organicMetrics: .init(
        likeCount: 5, userProfileClicks: 6, replyCount: 7, impressionCount: 8, retweetCount: 9),
      privateMetrics: .init(impressionCount: 11, userProfileClicks: 22),
      attachments: .init(mediaKeys: ["mediaKey1", "mediaKey2"], pollID: "pollID"),
      promotedMetrics: .init(
        impressionCount: 33, urlLinkClicks: 44, userProfileClicks: 55, retweetCount: 66,
        replyCount: 77),
      withheld: .init(
        copyright: true, countryCodes: ["countryCode1", "countryCode2"], scope: .tweet),
      contextAnnotations: [
        .init(
          domain: .init(id: "id", name: "name", description: "description"),
          entity: .init(id: "id", name: "name", description: "description"))
      ],
      entity: .init(
        annotations: [
          .init(start: 1, end: 2, probability: 3, type: .product, normalizedText: "normalizedText")
        ],
        urls: [
          .init(
            start: 4,
            end: 5,
            url: .init(string: "https://twitter.com")!,
            expandedURL: "https://twitter.com",
            displayURL: "https://twitter.com",
            unwoundURL: "https://twitter.com",
            images: [
              .init(
                url: .init(string: "https://twitter.com")!, size: .init(width: 100, height: 200))
            ],
            status: 21,
            title: "title",
            description: "description"
          )
        ],
        hashtags: [.init(start: 3, end: 4, tag: "tag")],
        mentions: [.init(start: 4, end: 7, userName: "userName")],
        cashtags: [.init(start: 43, end: 51, tag: "cashTag")]
      ),
      referencedTweets: [.init(id: "id", type: .retweeted)],
      editHistoryTweetIDs: ["edit1", "edit2"],
      editControl: .init(isEditEligible: true, editableUntil: Date(), editsRemaining: 3)
    )

    let data = try JSONEncoder().encode(tweet)

    let decodedTweet = try JSONDecoder().decode(Sweet.TweetModel.self, from: data)

    XCTAssertEqual(tweet, decodedTweet)
  }

  func testPlaceModelCodable() throws {
    let place1 = Sweet.PlaceModel(
      id: "id", fullName: "fullName", name: "name", country: "country", countryCode: "countryCode",
      geo: .init(type: .feature, boundingBox: [100.0]), type: .admin, containedWithin: ["1", "2"])

    let data = try JSONEncoder().encode(place1)

    let place2 = try JSONDecoder().decode(Sweet.PlaceModel.self, from: data)

    XCTAssertEqual(place1, place2)
  }

  func testMediaModelCodable() throws {
    let media1 = Sweet.MediaModel(
      key: "key", type: .animatedGig, size: .init(width: 100, height: 200),
      previewImageURL: .init(string: "https://twitter.com")!,
      url: .init(string: "https://twitter.com")!,
      variants: [
        .init(bitRate: 100, contentType: .mp4, url: .init(string: "https://twitter.com")!)
      ], durationMicroSeconds: 100, alternateText: "alternateText", metrics: .init(viewCount: 200),
      privateMetrics: .init(
        viewCount: 1, playback0Count: 2, playback25Count: 3, playback50Count: 4, playback75Count: 5,
        playback100Count: 6),
      promotedMetrics: .init(
        viewCount: 1, playback0Count: 2, playback25Count: 4, playback50Count: 3, playback75Count: 5,
        playback100Count: 6),
      organicMetrics: .init(
        viewCount: 0, playback0Count: 1, playback25Count: 2, playback50Count: 3, playback75Count: 4,
        playback100Count: 5))

    let data = try JSONEncoder().encode(media1)

    let media2 = try JSONDecoder().decode(Sweet.MediaModel.self, from: data)

    XCTAssertEqual(media1, media2)
  }

  func testListModelCodable() throws {
    let list1 = Sweet.ListModel(
      id: "id", name: "name", followerCount: 123, memberCount: 1222, ownerID: "ownerID",
      description: "description", isPrivate: true, createdAt: Date())

    let data = try JSONEncoder().encode(list1)

    let list2 = try JSONDecoder().decode(Sweet.ListModel.self, from: data)

    XCTAssertEqual(list1, list2)
  }

  func testSpaceModelCodable() throws {
    let space1 = Sweet.SpaceModel(
      id: "id", state: .all, creatorID: "createID", title: "title", hostIDs: ["hostID1"],
      lang: "lang", participantCount: 33, isTicketed: false, startedAt: Date(), updatedAt: Date(),
      createdAt: Date(), endedAt: Date(), invitedUserIDs: ["42334234", "434343"],
      scheduledStart: Date(),
      speakerIDs: ["32444334", "4343434"], subscriberCount: 3232,
      topicIDs: ["324234234", "43242342"])

    let data = try JSONEncoder().encode(space1)

    let space2 = try JSONDecoder().decode(Sweet.SpaceModel.self, from: data)

    XCTAssertEqual(space1, space2)
  }

  func testDirectMessageModelCodable() throws {
    let dm1 = Sweet.DirectMessageModel(
      eventType: .messageCreate, id: "id", text: "text", conversationID: "conversationID",
      createdAt: Date(), senderID: "senderID", attachments: .init(mediaKeys: ["1", "2"]),
      referencedTweets: [.init(id: "id")])

    let data = try JSONEncoder().encode(dm1)

    let dm2 = try JSONDecoder().decode(Sweet.DirectMessageModel.self, from: data)

    XCTAssertEqual(dm1, dm2)
  }

  func testJSONFileDecodable() throws {
    for i in (1..<4) {
      let path = Bundle.module.path(forResource: "TweetsData\(i)", ofType: "json")!
      let rawString = try String(contentsOfFile: path)
      let rawData = rawString.data(using: .utf8)!

      let response = try JSONDecoder.twitter.decode(Sweet.TweetsResponse.self, from: rawData)
      print(response)
    }
  }
}
