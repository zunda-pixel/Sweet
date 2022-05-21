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
    
    let response = try await Sweet.test.lookUpTweets(by: tweetIDs)
    
    response.tweets.forEach {
      print($0)
    }
  }
  
  func testLookUpTweet() async throws {
    let tweetID = "1506723004994174981"
    
    let response = try await Sweet.test.lookUpTweet(by: tweetID)
    
    print(response.tweet)
    print(response.users)
    print(response.polls)
    print(response.places)
    print(response.medias)
    print(response.relatedTweets)
  }
  
  func testCreateTweet() async throws {
    let text = UUID().uuidString
    
    let postTweetModel = Sweet.PostTweetModel(text: text, directMessageDeepLink: nil, forSuperFollowersOnly: false,
                                              geo: nil, media: nil, poll: .init(options: ["OK", "SAKANA"], durationMinutes: 10), quoteTweetID: nil, reply: nil, replySettings: nil)
    let tweet = try await Sweet.test.createTweet(postTweetModel)
    
    print(tweet)
  }
  
  func testDeleteTweet() async throws {
    let tweetID = "1490010315945177088"
    
    try await Sweet.test.deleteTweet(by: tweetID)
  }
  
  func testFetchTimeLine() async throws {
    let userID = testMyUserID
    let response = try await Sweet.test.fetchTimeLine(by: userID)
    
    print(response.tweets)
    print(response.users)
    print(response.medias)
    print(response.relatedTweets)
    print(response.polls)
    print(response.places)
    print(response.meta!)
  }
  
  func testFetchMentions() async throws {
    let userID = testMyUserID
    let response = try await Sweet.test.fetchMentions(by: userID)
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testSearchRecentTweet() async throws {
    let query = "#twitterapiv2"
    let response = try await Sweet.test.searchRecentTweet(by: query)
    
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testSearchTweet() async throws {
    let query = "#twitterapiv2"
    let response = try await Sweet.test.searchTweet(by: query)
    
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testFetchRecentCountTweet() async throws {
    let query = "#twitterapiv2"
    
    let response = try await Sweet.test.fetchRecentCountTweet(by: query)
    
    print(response.meta)
    
    response.countTweets.forEach {
      print($0)
    }
  }
  
  func testFetchCountTweet() async throws {
    let query = "#twitterapiv2"
    
    let response = try await Sweet.test.fetchCountTweet(by: query)
    
    print(response.meta)
    
    response.countTweets.forEach {
      print($0)
    }
  }
  
  func testFetchStreamRule() async throws {
    let response = try await Sweet.test.fetchStreamRule()
    
    print(response.meta)
    
    response.streamRules.forEach {
      print($0)
    }
  }
  
  func testFetchStream() async throws {
    let stream = TestStream()
    stream.testFilteredStreams()
    let timeoutSeconds:UInt64 = 60 * 3 * 1_000_000_000
    try await Task.sleep(nanoseconds: timeoutSeconds)
  }
  
  func testCreateStreamRule() async throws {
    let streamModels: [Sweet.StreamRuleModel] = [
      .init(value: "zunda633", tag: nil),
    ]
    
    let streamRuleModel = try await Sweet.test.createStreamRule(streamModels)
    
    print(streamRuleModel)
  }
  
  func testDeleteStreamRuleByID() async throws {
    let ids = [
      "1484489761767104513",
      "1482602294482857989",
      "1482602422727966722",
    ]
    
    try await Sweet.test.deleteStreamRule(ids: ids)
  }
  
  func testDeleteStreamRuleByValue() async throws {
    let values = [
      "meme",
      "cat has:media"
    ]
    
    try await Sweet.test.deleteStreamRule(values: values)
  }
  
  func testFetchStreamVolume() async throws {
    let testStream = TestStream()
    testStream.testVolumeStreams()
    let timeoutSeconds: UInt64 = 60 * 3 * 1_000_000_000
    try await Task.sleep(nanoseconds: timeoutSeconds)
  }
  
  func testFetchRetweetUsers() async throws {
    let tweetID = "1505700468617617414"
    
    let response = try await Sweet.test.fetchRetweetUsers(by: tweetID)
    
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
    
    let response = try await Sweet.test.fetchLikingTweetUser(by: tweetID)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testFetchLikedTweet() async throws {
    let userID = testMyUserID
    
    let response = try await Sweet.test.fetchLikedTweet(by: userID)
    
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

    let response = try await Sweet.test.fetchQuoteTweets(tweetID: tweetID, paginationToken: nil, maxResults: 10)
    
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

    let response = try await Sweet.test.fetchBookmarks(userID: userID)

    print(response)
  }
}

class TestStream: NSObject, URLSessionDataDelegate {
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    if let response = try? JSONDecoder().decode(Sweet.TweetResponse.self, from: data) {
      print(response.tweet)
    }
  }
  
  func testVolumeStreams() {
    let task = Sweet.test.fetchStreamVolume(delegate: self)
    task.resume()
  }
  
  func testFilteredStreams() {
    let task = Sweet.test.fetchStream(delegate: self)
    task.resume()
  }
}
