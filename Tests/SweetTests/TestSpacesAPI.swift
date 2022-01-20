//
//  TestSpacesAPI.swift
//
//
//  Created by zunda on 2022/01/17.
//

import XCTest
@testable import Sweet

final class TestSpacesAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"
  
  func testFetchSpace() async throws {
    let spaceID = "1dRJZlVzpNgKB"
    
    let sweet = Sweet.exampleSweet()
    let space = try await sweet.fetchSpace(spaceID: spaceID)
    
    print(space)
  }
  
  func testFetchSpaces() async throws {
    let spaceIDs = ["1dRJZlVzpNgKB"]
    
    let sweet = Sweet.exampleSweet()
    let spaces = try await sweet.fetchSpaces(spaceIDs: spaceIDs)
    
    spaces.forEach {
      print($0.id)
    }
  }
  
  func testFetchSpaceBuyers() async throws {
    let spaceID = "1dRJZlVzpNgKB"
    
    let sweet = Sweet.exampleSweet()
    let users = try await sweet.fetchSpaceBuyers(spaceID: spaceID)
    
    users.forEach {
      print($0.username)
    }
  }
  
  func testFetchSpaceTweets() async throws {
    let spaceID = "1dRJZlVzpNgKB"
    
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchSpaceTweets(spaceID: spaceID)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testSearchSpace() async throws {
    let query = "hello"
    
    let sweet = Sweet.exampleSweet()
    let spaces = try await sweet.searchSpaces(query: query)
    
    spaces.forEach {
      print($0.id)
    }
  }
}
