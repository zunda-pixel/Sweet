//
//  TestTweetsAPI.swift
//
//
//  Created by zunda on 2022/01/15.
//

import XCTest

@testable import Sweet

final class TestTweetsAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"

  func testLookUpTweets() async throws {
    let tweetIDs = ["1489644269447315458", "1489895008300056578"]

    let response = try await Sweet.test.tweets(by: tweetIDs)

    response.tweets.forEach {
      print($0)
    }
  }

  func testLookUpTweet() async throws {
    let tweetID = "1572253944348545026"

    let response = try await Sweet.test.tweet(by: tweetID)

    print(response)
  }

  func testCreateTweet() async throws {
    let text = UUID().uuidString

    let postTweetModel = Sweet.PostTweetModel(
      text: text,
      directMessageDeepLink: nil,
      forSuperFollowersOnly: false,
      geo: nil,
      media: nil,
      poll: .init(options: ["option1", "option2"], durationMinutes: 10),
      quoteTweetID: nil,
      reply: nil,
      replySettings: nil
    )

    let tweet = try await Sweet.test.createTweet(postTweetModel)

    print(tweet)
  }

  func testDeleteTweet() async throws {
    let tweetID = "1490010315945177088"

    try await Sweet.test.deleteTweet(of: tweetID)
  }

  func testFetchReverseChronological() async throws {
    let userID = testMyUserID
    let response = try await Sweet.test.reverseChronological(userID: userID)

    print(response)
  }

  func testFetchTimeLine() async throws {
    let userID = testMyUserID
    let response = try await Sweet.test.timeLine(userID: userID)

    print(response)
  }

  func testFetchMentions() async throws {
    let userID = testMyUserID
    let response = try await Sweet.test.mentions(userID: userID)
    response.tweets.forEach {
      print($0)
    }

    print(response.meta!)
  }

  func testSearchRecentTweet() async throws {
    let query = "#twitterapiv2"
    let response = try await Sweet.test.searchRecentTweet(query: query)

    response.tweets.forEach {
      print($0)
    }

    print(response.meta!)
  }

  func testSearchTweet() async throws {
    let query = "#twitterapiv2"
    let response = try await Sweet.test.searchTweet(query: query)

    response.tweets.forEach {
      print($0)
    }

    print(response.meta!)
  }

  func testFetchRecentCountTweet() async throws {
    let query = "#twitterapiv2"

    let response = try await Sweet.test.recentCountTweet(query: query)

    print(response.meta)

    response.countTweets.forEach {
      print($0)
    }
  }

  func testFetchCountTweet() async throws {
    let query = "#twitterapiv2"

    let response = try await Sweet.test.countTweet(query: query)

    print(response.meta)

    response.countTweets.forEach {
      print($0)
    }
  }

  func testFetchRetweetUsers() async throws {
    let tweetID = "1505700468617617414"

    let response = try await Sweet.test.retweetUsers(tweetID: tweetID)

    print(response.meta!)

    response.users.forEach {
      print($0)
    }
  }

  func testRetweet() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"

    try await Sweet.test.retweet(userID: userID, tweetID: tweetID)
  }

  func testDeleteRetweet() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"

    try await Sweet.test.deleteRetweet(userID: userID, tweetID: tweetID)
  }

  func testFetchLikingTweetUser() async throws {
    let tweetID = "1481674458586927105"

    let response = try await Sweet.test.likingTweetUsers(tweetID: tweetID)

    print(response.meta!)

    response.users.forEach {
      print($0)
    }
  }

  func testFetchLikedTweet() async throws {
    let userID = testMyUserID

    let response = try await Sweet.test.likedTweet(userID: userID)

    response.tweets.forEach {
      print($0)
    }

    print(response.meta!)
  }

  func testLike() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"

    try await Sweet.test.like(userID: userID, tweetID: tweetID)
  }

  func testUnLike() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"

    try await Sweet.test.unLike(userID: userID, tweetID: tweetID)
  }

  func testHideReply() async throws {
    let tweetID = "1505738024050917376"

    try await Sweet.test.hideReply(tweetID: tweetID, hidden: false)
  }

  func testFetchQuoteTweets() async throws {
    let tweetID = "1503755656771346447"

    let response = try await Sweet.test.quoteTweets(
      source: tweetID, paginationToken: nil, maxResults: 10)

    print(response.meta!)

    response.tweets.forEach {
      print($0)
    }
  }

  func testAddBookmark() async throws {
    let userID = testMyUserID

    let tweetID = "1509951255388504066"

    try await Sweet.test.addBookmark(userID: userID, tweetID: tweetID)
  }

  func testDeleteBookmark() async throws {
    let userID = testMyUserID

    let tweetID = "1509951255388504066"

    try await Sweet.test.deleteBookmark(userID: userID, tweetID: tweetID)
  }

  func testFetchBookmarks() async throws {
    let userID = testMyUserID

    let response = try await Sweet.test.bookmarks(userID: userID)

    print(response)
  }
}
