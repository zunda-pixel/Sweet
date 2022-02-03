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
  let fields: [UserField] = UserField.allCases
  
  func testUnFollow() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    
    let sweet = Sweet.sweetForTest()
    let folloing = try await sweet.unFollow(from: fromUserID, to: toUserID)
    
    print("folloing: \(folloing)")
  }
  
  func testFollow() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    
    let sweet = Sweet.sweetForTest()
    let (folloing, pendingFollow) = try await sweet.follow(from: fromUserID, to: toUserID)
    
    print("folloing: \(folloing)")
    print("pendingFollow: \(pendingFollow)")
  }
  
  func testFatchFollowing() async throws {
    let userID = "2244994945"
    
    let sweet = Sweet.sweetForTest()

    let userModels = try await sweet.fetchFolloing(by: userID, fields: fields)
    
    userModels.forEach {
      print($0)
    }
  }
  
  func testFetchFollower() async throws {
    let userID = "2244994945"
    let sweet = Sweet.sweetForTest()
    let userModels = try await sweet.fetchFollower(by: userID, fields: fields)
    
    userModels.forEach {
      print($0)
    }
  }
  
  func testLookUpUserByUserID() async throws {
    let userID = "2244994945"
    let sweet = Sweet.sweetForTest()
    let userModel = try await sweet.lookUpUser(userID: userID, fields: fields)
    
    print(userModel)
  }
  
  func testLookUpUserByScreenID() async throws {
    let userID = "zunda_pixel"
    let sweet = Sweet.sweetForTest()
    let userModel = try await sweet.lookUpUser(screenID: userID, fields: fields)
    print(userModel)
  }
  
  func testLookUpUsersByUserID() async throws {
    let userIDs = ["2244994945", "1048032521361866752"]
    let sweet = Sweet.sweetForTest()
    let userModels = try await sweet.lookUpUsers(userIDs: userIDs, fields: fields)
    
    userModels.forEach {
      print($0)
    }
  }
  
  func testLookUpUsersByScreenID() async throws {
    let userIDs = ["zunda_pixel", "zunda"]
    let sweet = Sweet.sweetForTest()
    let userModels = try await sweet.lookUpUsers(screenIDs: userIDs, fields: fields)
    
    userModels.forEach {
      print($0)
    }
  }
  
  func testLookUpMe() async throws {
    let sweet = Sweet.sweetForTest()
    let userModel = try await sweet.lookUpMe(fields: fields)
    print(userModel)
  }
  
  func testBlockUser() async throws {
    let fromUserID = "1048032521361866752"
    let toUserID = "2244994945"
    let sweet = Sweet.sweetForTest()
    let userModel = try await sweet.blockUser(from: fromUserID, to: toUserID)
    
    print(userModel)
  }
  
  func testFetchBlockUser() async throws {
    let userID = testMyUserID
    let sweet = Sweet.sweetForTest()
    let userModels = try await sweet.fetchBlocking(by: userID, fields: fields)
    
    userModels.forEach {
      print($0)
    }
  }
  
  func testUnBlockUser() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    let sweet = Sweet.sweetForTest()
    let userModel = try await sweet.unBlockUser(from: fromUserID, to: toUserID)
    
    print(userModel)
  }
  
  func testMuteUser() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    let sweet = Sweet.sweetForTest()
    let userModel = try await sweet.muteUser(from: fromUserID, to: toUserID)
    print(userModel)
  }
  
  func testFetchMutingUser() async throws {
    let userID = testMyUserID
    let sweet = Sweet.sweetForTest()
    let userModels = try await sweet.fetchMuting(by: userID, fields: fields)
    
    userModels.forEach {
      print($0)
    }
  }
  
  func testUnMuteUser() async throws {
    let fromUserID = testMyUserID
    let toUserID = "2244994945"
    let sweet = Sweet.sweetForTest()
    let userModel = try await sweet.unMuteUser(from: fromUserID, to: toUserID)
    
    print(userModel)
  }
}
