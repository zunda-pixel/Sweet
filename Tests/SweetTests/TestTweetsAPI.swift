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
            .lang, .nonPublicMetrics, .possiblySensitive, .publicMetrics, .replySettings,
            .withheld, .source, .referencedTweets, .organicMetrics] // promotedMetrics
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
    let tweets = try await sweet.lookUpTweets(by: tweetIDs, tweetFields: TweetField.normalTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    tweets.forEach {
      print($0)
    }
  }
  
  func testLookUpTweet() async throws {
    let tweetID = "1489644269447315458"
    
    let sweet = Sweet.sweetForTest()
    let tweet = try await sweet.lookUpTweet(by: tweetID, tweetFields: TweetField.normalTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    print(tweet)
  }
  
  func testCreateTweet() async throws {
    let text = UUID().uuidString
    
    let sweet = Sweet.sweetForTest()
    let postTweetModel = PostTweetModel(text: text, poll: .init(options: ["OK", "SAKANA"], durationMinutes: 10))
    let tweet = try await sweet.createTweet(postTweetModel)
    
    print(tweet)
  }
  
  func testDeleteTweet() async throws {
    let tweetID = "1490010315945177088"
    
    let sweet = Sweet.sweetForTest()
    let isDeleted = try await sweet.deleteTweet(by: tweetID)
    
    print(isDeleted)
  }
  
  func testFetchTimeLine() async throws {
    let userID = testMyUserID
    let sweet = Sweet.sweetForTest()
    let tweets = try await sweet.fetchTimeLine(by: userID, tweetFields: TweetField.normalTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    tweets.forEach {
      print($0)
    }
  }
  
  func testFetchMentions() async throws {
    let userID = testMyUserID
    let sweet = Sweet.sweetForTest()
    let tweets = try await sweet.fetchMentions(by: userID, tweetFields: TweetField.normalTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    tweets.forEach {
      print($0)
    }
  }
  
  func testSearchRecentTweet() async throws {
    let query = "#twitterapiv2"
    let sweet = Sweet.sweetForTest()
    let tweets = try await sweet.searchRecentTweet(by: query, tweetFields: TweetField.exceptTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases) // promotedMetric nonPublicMetrics organicMetrics
    
    tweets.forEach {
      print($0)
    }
  }
  
  func testSearchTweet() async throws {
    let query = "#twitterapiv2"
    let sweet = Sweet.sweetForTest()
    let tweets = try await sweet.searchTweet(by: query, tweetFields: TweetField.exceptTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases) // promotedMetric  nonPublicMetrics organicMetrics
    
    tweets.forEach {
      print($0)
    }
  }
  
  func testFetchRecentCountTweet() async throws {
    let query = "#twitterapiv2"
    
    let sweet = Sweet.sweetForTest()
    let countTweetModels = try await sweet.fetchRecentCountTweet(by: query)
    
    countTweetModels.forEach {
      print($0)
    }
  }
  
  func testFetchCountTweet() async throws {
    let query = "#twitterapiv2"
    
    let sweet = Sweet.sweetForTest()
    let tweets = try await sweet.fetchCountTweet(by: query)
    
    tweets.forEach {
      print($0)
    }
  }
  
  func testFetchStreamRule() async throws {
    let sweet = Sweet.sweetForTest()
    let streamRuleModels = try await sweet.fetchStreamRule()
    
    streamRuleModels.forEach {
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
    let streamModels: [StreamRuleModel] = [
      .init(value: "zunda671", tag: nil),
    ]
    
    let sweet = Sweet.sweetForTest()
    let streamRuleModels = try await sweet.createStreamRule(streamModels)
    
    streamRuleModels.forEach {
      print($0)
    }
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
    let tweetID = "1490127441318543361"
    
    let sweet = Sweet.sweetForTest()
    let users = try await sweet.fetchRetweetUsers(by: tweetID, userFields: UserField.allCases, mediaFields: MediaField.allCases ,placeFields: PlaceField.allCases)
    
    users.forEach {
      print($0)
    }
  }
  
  func testRetweet() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    let retweeted = try await sweet.retweet(userID: userID, tweetID: tweetID)
    
    print(retweeted)
  }
  
  func testDeleteRetweet() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    let retweeted = try await sweet.deleteRetweet(userID: userID, tweetID: tweetID)
    
    print(retweeted)
  }
  
  func testFetchLikingTweetUser() async throws {
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    let users = try await sweet.fetchLikingTweetUser(by: tweetID, userFields: UserField.allCases, mediaFields: MediaField.allCases ,pollFields: PollField.allCases)
    
    users.forEach {
      print($0)
    }
  }
  
  func testFetchLikedTweet() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.sweetForTest()
    let tweets = try await sweet.fetchLikedTweet(by: userID, tweetFields: TweetField.exceptTweetFileds, mediaFields: MediaField.allCases ,pollFields: PollField.allCases) // promotedMetric organicMetrics nonPublicMetrics
    
    tweets.forEach {
      print($0)
    }
  }
  
  func testLike() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    let liked = try await sweet.like(userID: userID, tweetID: tweetID)
    print(liked)
  }
  
  func testUnLike() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.sweetForTest()
    let liked = try await sweet.unLike(userID: userID, tweetID: tweetID)
    print(liked)
  }
  
  func testHideReply() async throws {
    let tweetID = "1489557936397426688"
    
    let sweet = Sweet.sweetForTest()
    let hidden = try await sweet.hideReply(tweetID: tweetID, hidden: true)
    print(hidden)
  }
}


class TestStream: NSObject, URLSessionDataDelegate {
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    if let response = try? JSONDecoder().decode(TweetResponseModel.self, from: data) {
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
