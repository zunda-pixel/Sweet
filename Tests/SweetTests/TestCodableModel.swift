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
    let response = try await Sweet.test.lookUpMe()

    let data = try JSONEncoder().encode(response.user)

    let userData = try JSONDecoder().decode(Sweet.UserModel.self, from: data)

    XCTAssertEqual(userData, response.user)
  }

  func testTweetModelCodable() async throws {
    let response = try await Sweet.test.lookUpTweet(id: "1528605562954727425")

    let data = try JSONEncoder().encode(response.tweet)

    let tweetData = try JSONDecoder().decode(Sweet.TweetModel.self, from: data)

    XCTAssertEqual(tweetData, response.tweet)
  }

  func testUserModelCodableOffline() async throws {
    let twitterDateString = "2020-05-15T16:03:42.000Z"
    let twitterDate = Sweet.TwitterDateFormatter().date(from: twitterDateString)!

    let user: Sweet.UserModel = .init(id: "id", name: "name", userName: "userName", verified: true, profileImageURL: .init(string: "https://twitter.com")!, description: "description", protected: true, url: .init(string: "https://twitter.com")!, createdAt: twitterDate, location: "location", pinnedTweetID: "pinnedTweetID", metrics: .init(followersCount: 1, followingCount: 2, tweetCount: 3, listedCount: 4), withheld: .init(copyright: true, countryCodes: ["countryCode1", "countryCode2"], scope: .user), entity: .init(urls: [.init(start: 1, end: 2, url: .init(string: "https://twitter.com")!, expandedURL: "https://twitter.com", displayURL: "https://twitter.com", unwoundURL: "https://twitter.com", images: [.init(url: .init(string: "https://twitter.com")!, size: .init(width: 100, height: 200))], status: 3, title: "title", description: "description")], descriptionURLs: [.init(start: 3, end: 4, url: .init(string: "https://twitter.com")!, expandedURL: "https://twitter.com", displayURL: "https://twitter.com", unwoundURL: "https://twitter.com", images: [.init(url: .init(string: "https://twitter.com")!, size: .init(width: 33, height: 44))], status: 3, title: "title", description: "description")], hashTags: [.init(start: 1, end: 2, tag: "hashTag")], mentions: [.init(start: 3, end: 4, userName: "userName")], cashTags: [.init(start: 1, end: 2, tag: "cashTag")]))

    let data = try JSONEncoder().encode(user)

    let decodedUser = try JSONDecoder().decode(Sweet.UserModel.self, from: data)

    XCTAssertEqual(user, decodedUser)
  }

  func testTweetModelCodableOffline() async throws {
    let twitterDateString = "2020-05-15T16:03:42.000Z"
    let twitterDate = Sweet.TwitterDateFormatter().date(from: twitterDateString)!

    let tweet: Sweet.TweetModel = .init(id: "id", text: "text", authorID: "authorID", lang: "lang", replySetting: .following, createdAt: twitterDate, source: "source", sensitive: true, conversationID: "coversationID", replyUserID: "replyUserID", geo: .init(placeID: "placeID"), publicMetrics: .init(retweetCount: 1, replyCount: 2, likeCount: 3, quoteCount: 4), organicMetrics: .init(likeCount: 5, userProfileClicks: 6, replyCount: 7, impressionCount: 8, retweetCount: 9), privateMetrics: .init(impressionCount: 11, userProfileClicks: 22), attachments: .init(mediaKeys: ["mediaKey1", "mediaKey2"], pollID: "pollID"), promotedMetrics: .init(impressionCount: 33, urlLinkClicks: 44, userProfileClicks: 55, retweetCount: 66, replyCount: 77), withheld: .init(copyright: true, countryCodes: ["countryCode1", "countryCode2"], scope: .tweet), contextAnnotations: [.init(domain: .init(id: "id", name: "name", description: "description"), entity: .init(id: "id", name: "name", description: "description"))], entity: .init(annotations: [.init(start: 1, end: 2, probability: 3, type: "type", normalizedText: "normalizedText")], urls: [.init(start: 4, end: 5, url: .init(string: "https://twitter.com")!, expandedURL: "https://twitter.com", displayURL: "https://twitter.com", unwoundURL: "https://twitter.com", images: [.init(url: .init(string: "https://twitter.com")!, size: .init(width: 100, height: 200))], status: 21, title: "title", description: "description")], hashTags: [.init(start: 3, end: 4, tag: "tag")], mentions: [.init(start: 4, end: 7, userName: "userName")], cashTags: [.init(start: 43, end: 51, tag: "cashTag")]), referencedTweet: Sweet.ReferencedTweetModel(id: "id", type: .retweeted))

    let data = try JSONEncoder().encode(tweet)

    let decodedTweet = try JSONDecoder().decode(Sweet.TweetModel.self, from: data)


    XCTAssertEqual(tweet, decodedTweet)
  }
}
