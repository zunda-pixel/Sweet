//
//  TestListsAPI.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import XCTest
@testable import Sweet

final class TestListsAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"
  
  func testFollowList() async throws {
    let userID = testMyUserID
    let listID = "900944005042585602"
    
    try await Sweet.test.followList(userID: userID, listID: listID)
  }
  
  func testUnFollowList() async throws {
    let userID = testMyUserID
    let listID = "900944005042585602"
    
    try await Sweet.test.unFollowList(userID: userID, listID: listID)
  }
  
  func testFetchFollowedUsers() async throws {
    let listID = "900944005042585602"
    
    let response = try await Sweet.test.fetchFollowedUsers(listID: listID)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testFetchFollowingLists() async throws {
    let userID = testMyUserID
    
    let response = try await Sweet.test.fetchFollowingLists(userID: userID)
    
    print(response.meta)
    
    response.lists.forEach {
      print($0)
    }
  }
  
  func testAddListMember() async throws {
    let userID = "2244994945"
    let listID = "1489620669822160899"
    
    try await Sweet.test.addListMember(to: listID, userID: userID)
  }
  
  func testDeleteListMember() async throws {
    let userID = "2244994945"
    let listID = "1489620669822160899"
    
    try await Sweet.test.deleteListMember(from: listID, userID: userID)
  }
  
  func testFetchAddedLists() async throws {
    let userID = testMyUserID
    
    let response = try await Sweet.test.fetchAddedLists(userID: userID)
    
    print(response.meta)
    
    response.lists.forEach {
      print($0)
    }
  }
  
  func testFetchAddingUsers() async throws {
    let listID = "1463289657190404097"
    
    let response = try await Sweet.test.fetchAddedUsersToList(listID: listID)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testFetchList() async throws {
    let listID = "1463289657190404097"
    
    let list = try await Sweet.test.fetchList(listID: listID)
    
    print(list)
  }
  
  func testFetchOwnedLists() async throws {
    let userID = testMyUserID
    
    let response = try await Sweet.test.fetchOwnedLists(userID: userID)
    
    print(response.meta)
    
    response.lists.forEach {
      print($0)
    }
  }
  
  func testFetchListTweets() async throws {
    let listID = "1489539509792686081"
    
    let response = try await Sweet.test.fetchListTweets(listID: listID)
    
    response.tweets.forEach {
      print($0)
    }
    
    print(response.meta!)
  }
  
  func testCreateList() async throws {
    let list = try await Sweet.test.createList(name: "fsdaji", description: "fdaslkfj;a", isPrivate: true)
    
    print(list)
  }
  
  func testUpdateList() async throws {
    let listID = "1489620669822160899"
    
    try await Sweet.test.updateList(listID: listID, name: "changed name", description: "changed description", isPrivate: false)
  }
  
  func testDeleteList() async throws {
    let listID = "1489548406032769025"
    
    try await Sweet.test.deleteList(by: listID)
  }
  
  func testPinList() async throws {
    let userID = testMyUserID
    let listID = "1489620669822160899"
    
    try await Sweet.test.pinList(userID: userID, listID: listID)
  }
  
  func testUnPinList() async throws {
    let userID = testMyUserID
    let listID = "1489548406032769025"
    
    try await Sweet.test.unPinList(userID: userID, listID: listID)
  }
  
  func testFetchPinnedLists() async throws {
    let userID = testMyUserID
    
    let response = try await Sweet.test.fetchPinnedLists(userID: userID)
    
    print(response.meta)
    
    response.lists.forEach {
      print($0)
    }
  }
}
