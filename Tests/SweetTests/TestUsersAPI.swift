//
//  TestUsersAPI.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import XCTest
@testable import Sweet

final class TestUsersAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"
  
  func testUnFollow() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    
    try await Sweet.test.unFollow(from: fromUserID, to: toUserID)
  }
  
  func testFollow() async throws {
    let fromUserID = testMyUserID
    let toUserID = "355848148"
    let (following, pendingFollow) = try await Sweet.test.follow(from: fromUserID, to: toUserID)
    
    print(following)
    print(pendingFollow)
  }
  
  func testFatchFollowing() async throws {
    let userID = testMyUserID
    let response = try await Sweet.test.fetchFollowing(by: userID)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testFetchFollower() async throws {
    let userID = "2244994945"
    let response = try await Sweet.test.fetchFollower(by: userID)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testLookUpUserByUserID() async throws {
    let userID = "2244994945"
    let userModel = try await Sweet.test.lookUpUser(userID: userID)
    
    print(userModel)
  }
  
  func testLookUpUserByScreenID() async throws {
    let userID = "zunda_pixel"
    let userModel = try await Sweet.test.lookUpUser(screenID: userID)
    print(userModel)
  }
  
  func testLookUpUsersByUserID() async throws {
    let userIDs = ["2244994945", "1048032521361866752"]
    let response = try await Sweet.test.lookUpUsers(userIDs: userIDs)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testLookUpUsersByScreenID() async throws {
    let userIDs = ["zunda_pixel", "zunda"]
    let response = try await Sweet.test.lookUpUsers(screenIDs: userIDs)
        
    response.users.forEach {
      print($0)
    }
  }
  
  func testLookUpMe() async throws {
    let userModel = try await Sweet.test.lookUpMe()
    print(userModel)
  }
  
  func testBlockUser() async throws {
    let fromUserID = "1048032521361866752"
    let toUserID = "2244994945"
    try await Sweet.test.blockUser(from: fromUserID, to: toUserID)
  }
  
  func testFetchBlockUser() async throws {
    let userID = testMyUserID
    let response = try await Sweet.test.fetchBlocking(by: userID)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testUnBlockUser() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    try await Sweet.test.unBlockUser(from: fromUserID, to: toUserID)
  }
  
  func testMuteUser() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    try await Sweet.test.muteUser(from: fromUserID, to: toUserID)
  }
  
  func testFetchMutingUser() async throws {
    let userID = testMyUserID
    let response = try await Sweet.test.fetchMuting(by: userID)
    
    print(response.meta!)
    
    response.users.forEach {
      print($0)
    }
  }
  
  func testUnMuteUser() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    try await Sweet.test.unMuteUser(from: fromUserID, to: toUserID)
  }
}
