//
//  TestTweetsAPI.swift
//  
//
//  Created by zunda on 2022/01/15.
//

import XCTest
@testable import Sweet

extension TweetField {
  static public var normalTweetFileds: [TweetField] {
    return [.id, .attachments, .geo, .authorID, .inReplyToUserID,
            .text, .contextAnnotations, .conversationID, .createdAt, .entities,
            .lang, .possiblySensitive, .publicMetrics, .replySettings,
            .withheld, .source, .referencedTweets] // promotedMetrics
  }
  
  static public var exceptTweetFileds: [TweetField] {
    return [.id, .attachments, .geo, .authorID, .inReplyToUserID,
            .text, .contextAnnotations, .conversationID, .createdAt, .entities,
            .lang, .possiblySensitive, .publicMetrics, .replySettings, .withheld,
            .source, .referencedTweets] // promotedMetric nonPublicMetrics
  }
}

final class TestTweetsAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"
  
  func testLookUpTweets() async throws {
    let tweetIDs = ["1489644269447315458", "1489895008300056578"]
    
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.lookUpTweets(by: tweetIDs, tweetFields: TweetField.normalTweetFileds, userFields: UserField.allCases,
                                                mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    response.tweets.forEach {
      print($0)
    }
  }
  
  func testLookUpTweet() async throws {
    let tweetID = "1489644269447315458"
    
    let sweet = Sweet.sweetForTest()
    let tweet = try await sweet.lookUpTweet(by: tweetID, tweetFields: TweetField.exceptTweetFileds, userFields: UserField.allCases,
                                            mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    print(tweet)
  }
  
  func testCreateTweet() async throws {
    let text = UUID().uuidString
    
    let sweet = Sweet.sweetForTest()
    let postTweetModel = Sweet.PostTweetModel(text: text, directMessageDeepLink: nil, forSuperFollowersOnly: false,
                                              geo: nil, media: nil, poll: .init(options: ["OK", "SAKANA"], durationMinutes: 10), quoteTweetID: nil, reply: nil, replySettings: nil)
    let tweet = try await sweet.createTweet(postTweetModel)
    
    print(tweet)
  }
  
  func testDeleteTweet() async throws {
    let tweetID = "1490010315945177088"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.deleteTweet(by: tweetID)
  }
  
  func testFetchTimeLine() async throws {
    let userID = testMyUserID
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.fetchTimeLine(by: userID, tweetFields: TweetField.normalTweetFileds, userFields: UserField.allCases,
                                                 mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testFetchMentions() async throws {
    let userID = testMyUserID
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.fetchMentions(by: userID, tweetFields: TweetField.normalTweetFileds, userFields: UserField.allCases,
                                                 mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testSearchRecentTweet() async throws {
    let query = "#twitterapiv2"
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.searchRecentTweet(by: query, tweetFields: TweetField.exceptTweetFileds, userFields: UserField.allCases,
                                                     mediaFields: MediaField.allCases ,pollFields: PollField.allCases) // promotedMetric privateMetrics organicMetrics
    
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testSearchTweet() async throws {
    let query = "#twitterapiv2"
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.searchTweet(by: query, tweetFields: TweetField.exceptTweetFileds, userFields: UserField.allCases,
                                               mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testFetchRecentCountTweet() async throws {
    let query = "#twitterapiv2"
    
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.fetchRecentCountTweet(by: query)
    
    print(response.meta)
    
    response.countTweets.forEach {
      print($0)
    }
  }
  
  func testFetchCountTweet() async throws {
    let query = "#twitterapiv2"
    
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.fetchCountTweet(by: query)
    
    print(response.meta)
    
    response.countTweets.forEach {
      print($0)
    }
  }
  
  func testFetchStreamRule() async throws {
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.fetchStreamRule()
    
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
    
    let sweet = Sweet.sweetForTest()
    let streamRuleModel = try await sweet.createStreamRule(streamModels)
    
    print(streamRuleModel)
  }
  
  func testDeleteStreamRuleByID() async throws {
    let ids = [
      "1484489761767104513",
      "1482602294482857989",
      "1482602422727966722",
    ]
    
    let sweet = Sweet.sweetForTest()
    try await sweet.deleteStreamRule(ids: ids)
  }
  
  func testDeleteStreamRuleByValue() async throws {
    let values = [
      "meme",
      "cat has:media"
    ]
    
    let sweet = Sweet.sweetForTest()
    try await sweet.deleteStreamRule(values: values)
  }
  
  func testFetchStreamVolume() async throws {
    let testStream = TestStream()
    testStream.testVolumeStreams()
    let timeoutSeconds: UInt64 = 60 * 3 * 1_000_000_000
    try await Task.sleep(nanoseconds: timeoutSeconds)
  }
  
  func testFetchRetweetUsers() async throws {
    let tweetID = "1505700468617617414"
    
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.fetchRetweetUsers(by: tweetID, userFields: UserField.allCases)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testRetweet() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.retweet(userID: userID, tweetID: tweetID)
  }
  
  func testDeleteRetweet() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.deleteRetweet(userID: userID, tweetID: tweetID)
  }
  
  func testFetchLikingTweetUser() async throws {
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.fetchLikingTweetUser(by: tweetID, userFields: UserField.allCases)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testFetchLikedTweet() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.sweetForTest()
    let response = try await sweet.fetchLikedTweet(by: userID, tweetFields: TweetField.exceptTweetFileds, userFields: UserField.allCases,
                                                   mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testLike() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.like(userID: userID, tweetID: tweetID)
  }
  
  func testUnLike() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.unLike(userID: userID, tweetID: tweetID)
  }
  
  func testHideReply() async throws {
    let tweetID = "1505738024050917376"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.hideReply(tweetID: tweetID, hidden: false)
  }
  
  func testFetchQuoteTweets() async throws {
    let sweet = Sweet.sweetForTest()
    let tweetID = "1503755656771346447"
    let tweetFields: [TweetField] = [.createdAt, .text, .authorID, .contextAnnotations, .conversationID, .geo, .id, .possiblySensitive, .publicMetrics, .referencedTweets, .replySettings, .inReplyToUserID]
    let response = try await sweet.fetchQuoteTweets(tweetID: tweetID, paginationToken: nil, maxResults: 10, tweetFields: tweetFields, userFields: UserField.allCases, placeFields: PlaceField.allCases, mediaFields: MediaField.allCases, pollFields: PollField.allCases)
    
    print(response.meta!)
    
    response.tweets.forEach {
      print($0)
    }
  }
}

class TestStream: NSObject, URLSessionDataDelegate {
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    if let response = try? JSONDecoder().decode(Sweet.TweetResponse.self, from: data) {
      print(response.tweet)
    }
  }
  
  func testVolumeStreams() {
    let sweet = Sweet.sweetForTest()
    let task = sweet.fetchStreamVolume(delegate: self, tweetFields: TweetField.normalTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    task.resume()
  }
  
  func testFilteredStreams() {
    let sweet = Sweet.sweetForTest()
    let task = sweet.fetchStream(delegate: self, tweetFields: TweetField.normalTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    task.resume()
  }
}
