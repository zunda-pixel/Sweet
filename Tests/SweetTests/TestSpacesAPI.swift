//
//  TestSpacesAPI.swift
//
//
//  Created by zunda on 2022/01/17.
//

import XCTest

@testable import Sweet

final class TestSpacesAPI: XCTestCase {
  func testFetchSpace() async throws {
    let spaceID = "1ZkKzbEYkReKv"

    let space = try await Sweet.test.fetchSpace(spaceID: spaceID)

    print(space)
  }

  func testFetchSpacesWithSpaceIDs() async throws {
    let spaceIDs = ["1gqGvlqjRRaxB"]

    let response = try await Sweet.test.fetchSpaces(spaceIDs: spaceIDs)

    response.spaces.forEach {
      print($0)
    }
  }

  func testFetchSpacesWithUserIDs() async throws {
    let userIDs = ["1048032521361866752"]

    let response = try await Sweet.test.fetchSpaces(creatorIDs: userIDs)

    response.spaces.forEach {
      print($0)
    }
  }

  func testFetchSpaceBuyers() async throws {
    let spaceID = "1gqGvlqjRRaxB"

    let response = try await Sweet.test.fetchSpaceBuyers(spaceID: spaceID)

    response.users.forEach {
      print($0)
    }
  }

  func testFetchSpaceTweets() async throws {
    let spaceID = "1ZkKzbpyNdeKv"

    let response = try await Sweet.test.fetchSpaceTweets(spaceID: spaceID)

    response.tweets.forEach {
      print($0)
    }
  }

  func testSearchSpace() async throws {
    let query = "円"

    let response = try await Sweet.test.searchSpaces(by: query)

    response.spaces.forEach {
      print($0)
    }
  }
}
