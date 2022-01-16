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
    let tweetIDs = ["1481674458586927105", "1480571976414543875"]
    
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.lookUpTweets(by: tweetIDs)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testLookUpTweet() async throws {
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.exampleSweet()
    let tweet = try await sweet.lookUpTweet(by: tweetID)
    
    print(tweet)
  }
  
  func testCreateTweet() async throws {
    let text = UUID().uuidString
    
    let sweet = Sweet.exampleSweet()
    let tweet = try await sweet.createTweet(text: text)
    
    print(tweet)
  }
  
  func testDeleteTweet() async throws {
    let tweetID = "1482357307178577923"
    
    let sweet = Sweet.exampleSweet()
    let isDeleted = try await sweet.deleteTweet(by: tweetID)
    
    print(isDeleted)
  }
  
  func testFetchTimeLine() async throws {
    let userID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchTimeLine(by: userID)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testFetchMentions() async throws {
    let userID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchMentions(by: userID)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testSearchRecentTweet() async throws {
    let query = "from%3Atwitterdev%20new%20-is%3Aretweet"
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.searchRecentTweet(by: query)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testSearchTweet() async throws {
    let query = "from%3Atwitterdev%20new%20-is%3Aretweet"
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.searchTweet(by: query)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testFetchRecentCountTweet() async throws {
    let query = "lakers"
    
    let sweet = Sweet.exampleSweet()
    let countTweetModels = try await sweet.fetchRecentCountTweet(by: query)
    
    countTweetModels.forEach {
      print($0.countTweet)
    }
  }
  
  func testFetchCountTweet() async throws {
    let query = "lakers"
    
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchCountTweet(by: query)
    
    tweets.forEach {
      print($0.text)
    }
  }
}
