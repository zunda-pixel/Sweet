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
    
    let sweet = Sweet.sweetForTest()
    try await sweet.followList(userID: userID, listID: listID)    
  }
  
  func testUnFollowList() async throws {
    let userID = testMyUserID
    let listID = "900944005042585602"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.unFollowList(userID: userID, listID: listID)    
  }
  
  func testFetchFollowedUsers() async throws {
    let listID = "900944005042585602"
    
    let sweet = Sweet.sweetForTest()
    let (users, meta) = try await sweet.fetchFollowedUsers(listID: listID, userFields: UserField.allCases)
    
    print(meta)
    
    users.forEach {
      print($0)
    }
  }
  
  func testFetchFollowingLists() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.sweetForTest()
    let (lists, meta) = try await sweet.fetchFollowingLists(userID: userID, listFields: ListField.allCases)
    
    print(meta)
    
    lists.forEach {
      print($0)
    }
  }
  
  func testAddListMember() async throws {
    let userID = "2244994945"
    let listID = "1489620669822160899"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.addListMember(to: listID, userID: userID)
  }
  
  func testDeleteListMember() async throws {
    let userID = "2244994945"
    let listID = "1489620669822160899"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.deleteListMember(from: listID, userID: userID)
  }
  
  func testFetchAddedLists() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.sweetForTest()
    let (lists, meta) = try await sweet.fetchAddedLists(userID: userID, listFields: ListField.allCases)
    
    print(meta)
    
    lists.forEach {
      print($0)
    }
  }
  
  func testFetchAddingUsers() async throws {
    let listID = "1463289657190404097"
    
    let sweet = Sweet.sweetForTest()
    let (users, meta) = try await sweet.fetchAddedUsersToList(listID: listID, userFields: UserField.allCases)
    
    print(meta)
    
    users.forEach {
      print($0)
    }
  }
  
  func testFetchList() async throws {
    let listID = "1463289657190404097"
    
    let sweet = Sweet.sweetForTest()
    let list = try await sweet.fetchList(listID: listID, listFields: ListField.allCases)
    
    print(list)
  }
  
  func testFetchOwnedLists() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.sweetForTest()
    let (lists, meta) = try await sweet.fetchOwnedLists(userID: userID, listFields: ListField.allCases)
    
    print(meta)
    
    lists.forEach {
      print($0)
    }
  }
  
  func testFetchListTweets() async throws {
    let listID = "1489539509792686081"
    
    let sweet = Sweet.sweetForTest()
    let (tweets, meta) = try await sweet.fetchListTweets(listID: listID,
                                                 tweetFields: [.createdAt, .id, .replySettings, .geo, .text,
                                                               .attachments, .authorID, .contextAnnotations, .conversationID,
                                                               .inReplyToUserID, .entities, .lang, .possiblySensitive,
                                                               .referencedTweets, .withheld, .source,],
                                                 userFields: UserField.allCases) // privateMetrics, organicMetrics, promotedMetrics
    
    tweets.forEach {
      print($0)
    }
    
    print(meta)
  }
  
  func testCreateList() async throws {
    let sweet = Sweet.sweetForTest()
    let list = try await sweet.createList(name: "fsdaji", description: "fdaslkfj;a", isPrivate: true)
    
    print(list)
  }
  
  func testUpdateList() async throws {
    let listID = "1489548406032769025"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.updateList(listID: listID, name: "changed name", description: "changed description", isPrivate: false)    
  }
  
  func testDeleteList() async throws {
    let listID = "1489548406032769025"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.deleteList(by: listID)    
  }
  
  func testPinList() async throws {
    let userID = testMyUserID
    let listID = "1489548406032769025"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.pinList(userID: userID, listID: listID)
  }
  
  func testUnPinList() async throws {
    let userID = testMyUserID
    let listID = "1489548406032769025"
    
    let sweet = Sweet.sweetForTest()
    try await sweet.unPinList(userID: userID, listID: listID)
  }
  
  func testFetchPinnedLists() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.sweetForTest()
    let (lists, meta) = try await sweet.fetchPinnedLists(userID: userID, listFields: ListField.allCases)
    
    print(meta)
    
    lists.forEach {
      print($0)
    }
  }
}
