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
    let spaceID = "1PlKQazYdOqKE"
    
    let sweet = Sweet.sweetForTest()
    let space = try await sweet.fetchSpace(spaceID: spaceID, spaceFields: SpaceField.allCases)
    
    print(space)
  }
  
  func testFetchSpacesWithSpaceIDs() async throws {
    let spaceIDs = ["1PlKQazYdOqKE"]
    
    let sweet = Sweet.sweetForTest()
    let spaces = try await sweet.fetchSpaces(spaceIDs: spaceIDs, spaceFields: SpaceField.allCases)
    
    spaces.forEach {
      print($0)
    }
  }
  
  func testFetchSpacesWithUserIDs() async throws {
    let userIDs = ["1048032521361866752"]
    
    let sweet = Sweet.sweetForTest()
    let spaces = try await sweet.fetchSpaces(creatorIDs: userIDs, spaceFields: SpaceField.allCases)
    
    spaces.forEach {
      print($0)
    }
  }
  
  func testFetchSpaceBuyers() async throws {
    let spaceID = "1yNGaYRDnqXGj"
    
    let sweet = Sweet.sweetForTest()
    let (users, meta) = try await sweet.fetchSpaceBuyers(spaceID: spaceID, userFields: UserField.allCases)
    
    print(meta)
    
    users.forEach {
      print($0)
    }
  }
  
  func testFetchSpaceTweets() async throws {
    let spaceID = "1ZkKzbpyNdeKv"

    let sweet = Sweet.sweetForTest()
    let (tweets, meta) = try await sweet.fetchSpaceTweets(spaceID: spaceID, tweetFields: TweetField.allCases, userFields: UserField.allCases)
    
    tweets.forEach {
      print($0)
    }
    
    print(meta)
  }
  
  func testSearchSpace() async throws {
    let query = "円"
    
    let sweet = Sweet.sweetForTest()
    let spaces = try await sweet.searchSpaces(query: query, spaceFields: SpaceField.allCases)
    
    spaces.forEach {
      print($0)
    }
  }
}
