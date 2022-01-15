//
//  File.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import XCTest
@testable import Sweet

@available(macOS 12.0, iOS 13.0, *)
final class TestUsersAPI: XCTestCase {
  
  func testUnFollow() async throws {
    let fromUserID = "1048032521361866752"
    let toUserID = "2244994945"
    
    let sweet = Sweet.exampleSweet()
    let folloing = try await sweet.unFollow(from: fromUserID, to: toUserID)
    
    print("folloing: \(folloing)")
  }
  
  func testFollow() async throws {
    let fromUserID = "1048032521361866752"
    let toUserID = "2244994945"
    
    let sweet = Sweet.exampleSweet()
    let (folloing, pendingFollow) = try await sweet.follow(from: fromUserID, to: toUserID)
    
    print("folloing: \(folloing)")
    print("pendingFollow: \(pendingFollow)")
  }
  
  func testFatchFollowing() async throws {
    let userID = "2244994945"
    
    let sweet = Sweet.exampleSweet()
    let userModels = try await sweet.fetchFolloing(by: userID)
    
    userModels.forEach {
      print($0.name)
    }
  }
  
  func testFetchFollower() async throws {
    let userID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let userModels = try await sweet.fetchFollower(by: userID)
    
    userModels.forEach {
      print($0.username)
    }
  }
  
  func testLookUpUserByUserID() async throws {
    let userID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let userModel = try await sweet.lookUpUser(userID: userID)
    
    print(userModel)
  }
  
  func testLookUpUserByScreenID() async throws {
    let userID = "zunda_pixel"
    let sweet = Sweet.exampleSweet()
    let userModel = try await sweet.lookUpUser(screenID: userID)
    print(userModel)
  }
  
  func testLookUpUsersByUserID() async throws {
    let userIDs = ["2244994945", "1048032521361866752"]
    let sweet = Sweet.exampleSweet()
    let userModels = try await sweet.lookUpUsers(userIDs: userIDs)
    
    userModels.forEach {
      print($0.username)
    }
  }
  
  func testLookUpUsersByScreenID() async throws {
    let userIDs = ["zunda_pixel", "zunda"]
    let sweet = Sweet.exampleSweet()
    let userModels = try await sweet.lookUpUsers(screenIDs: userIDs)
    
    userModels.forEach {
      print($0.username)
    }
  }
  
  func testLookUpMe() async throws {
    let sweet = Sweet.exampleSweet()
    let userModel = try await sweet.lookUpMe()
    print(userModel)
  }
  
  func testBlockUser() async throws {
    let fromUserID = "1048032521361866752"
    let toUserID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let userModel = try await sweet.blockUser(from: fromUserID, to: toUserID)
    
    print(userModel)
  }
  
  func testFetchBlockUser() async throws {
    let userID = "1048032521361866752"
    let sweet = Sweet.exampleSweet()
    let userModels = try await sweet.fetchBlocking(by: userID)
    
    userModels.forEach {
      print($0.username)
    }
  }
  
  func testUnBlockUser() async throws {
    let fromUserID = "1048032521361866752"
    let toUserID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let userModel = try await sweet.unBlockUser(from: fromUserID, to: toUserID)
    
    print(userModel)
  }
  
  func testMuteUser() async throws {
    let fromUserID = "1048032521361866752"
    let toUserID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let userModel = try await sweet.muteUser(from: fromUserID, to: toUserID)
    print(userModel)
  }
  
  
  func testFetchMutingUser() async throws {
    let userID = "1048032521361866752"
    let sweet = Sweet.exampleSweet()
    let userModels = try await sweet.fetchMuting(by: userID)
    
    userModels.forEach {
      print($0.username)
    }
  }
  
  func testUnMuteUser() async throws {
    let fromUserID = "1048032521361866752"
    let toUserID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let userModel = try await sweet.unMuteUser(from: fromUserID, to: toUserID)
    
    print(userModel)
  }
}
