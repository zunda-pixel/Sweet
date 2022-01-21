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
    let listID = "1484484685069574145"
    
    let sweet = Sweet.exampleSweet()
    let following = try await sweet.followList(userID: userID, listID: listID)
    
    print(following)
  }
  
  func testUnFollowList() async throws {
    let userID = testMyUserID
    let listID = "1482973862237437952"
    
    let sweet = Sweet.exampleSweet()
    let following = try await sweet.unFollowList(userID: userID, listID: listID)
    
    print(following)
  }
  
  func testFetchFollowedUsers() async throws {
    let listID = "1484484685069574145"
    
    let sweet = Sweet.exampleSweet()
    let users = try await sweet.fetchFollowedUsers(listID: listID)
    
    users.forEach {
      print($0.username)
    }
  }
  
  func testFetchFollowingLists() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.exampleSweet()
    let lists = try await sweet.fetchFollowingLists(userID: userID)
    
    lists.forEach {
      print($0.id)
    }
  }
  
  func testAddListMember() async throws {
    let userID = "2244994945"
    let listID = "1482591443994968070"
    
    let sweet = Sweet.exampleSweet()
    let isMember = try await sweet.addListMember(to: listID, userID: userID)
    
    print(isMember)
  }
  
  func testDeleteListMember() async throws {
    let userID = "2244994945"
    let listID = "1482591443994968070"
    
    let sweet = Sweet.exampleSweet()
    let isMember = try await sweet.deleteListMember(from: listID, userID: userID)
    
    print(isMember)
  }
  
  func testFetchAddedLists() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.exampleSweet()
    let lists = try await sweet.fetchAddedLists(userID: userID)
    
    lists.forEach {
      print($0.id)
    }
  }
  
  func testFetchAddingUsers() async throws {
    let listID = "1463289657190404097"
    
    let sweet = Sweet.exampleSweet()
    let users = try await sweet.fetchAddedUsersToList(listID: listID)
    
    users.forEach {
      print($0.username)
    }
  }
  
  func testFetchList() async throws {
    let listID = "1463289657190404097"
    
    let sweet = Sweet.exampleSweet()
    let list = try await sweet.fetchList(listID: listID)
    
    print(list)
  }
  
  func testFetchOwnedLists() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.exampleSweet()
    let lists = try await sweet.fetchOwnedLists(userID: userID)
    
    lists.forEach {
      print($0.name)
    }
  }
  
  func testFetchListTweets() async throws {
    let listID = "1463289657190404097"
    
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchListTweets(listID: listID)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testCreateList() async throws {
    let sweet = Sweet.exampleSweet()
    let list = try await sweet.createList(name: "fsdaji", description: "fdaslkfj;a", isPrivate: false)
    
    print(list)
  }
  
  func testUpdateList() async throws {
    let listID = "1484484685069574145"
    
    let sweet = Sweet.exampleSweet()
    let updated = try await sweet.updateList(listID: listID, name: "changed name", description: "changed description", isPrivate: false)
    
    print(updated)
  }
  
  func testDeleteList() async throws {
    let listID = "1483088575860142080"
    
    let sweet = Sweet.exampleSweet()
    let isDeleted = try await sweet.deleteList(by: listID)
    
    print(isDeleted)
  }
  
  func testPinList() async throws {
    let userID = testMyUserID
    let listID = "1483089445230309376"
    
    let sweet = Sweet.exampleSweet()
    let isPinned = try await sweet.pinList(userID: userID, listID: listID)
    
    print(isPinned)
  }
  
  func testUnPinList() async throws {
    let userID = testMyUserID
    let listID = "1483089445230309376"
    
    let sweet = Sweet.exampleSweet()
    let isPinned = try await sweet.unPinList(userID: userID, listID: listID)
    
    print(isPinned)
  }
  
  func testFetchPinnedLists() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.exampleSweet()
    let lists = try await sweet.fetchPinnedLists(userID: userID)
    
    lists.forEach {
      print($0.name)
    }
  }
}
