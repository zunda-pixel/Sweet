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
    let response = try await Sweet.test.lookUpTweet(by: "1528605562954727425")

    let data = try JSONEncoder().encode(response.tweet)

    let tweetData = try JSONDecoder().decode(Sweet.TweetModel.self, from: data)

    XCTAssertEqual(tweetData, response.tweet)
  }
}
