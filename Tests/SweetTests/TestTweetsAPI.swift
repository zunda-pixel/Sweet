//
//  TestTweetsAPI.swift
//  
//
//  Created by zunda on 2022/01/15.
//

import XCTest
@testable import Sweet

@available(macOS 12.0, iOS 13.0, *)
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
}
