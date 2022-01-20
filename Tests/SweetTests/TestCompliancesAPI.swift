//
//  TestCompliancesAPI.swift
//
//
//  Created by zunda on 2022/01/15.
//

import XCTest
@testable import Sweet

final class TestCompliancesAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"
  
  func testFetchCompliances() async throws {
    let type: JobType = .tweets
    
    let sweet = Sweet.exampleSweet()
    let compliances = try await sweet.fetchCompliances(type: type)
    
    compliances.forEach {
      print($0.id)
    }
  }
  
  func testFetchCompliance() async throws {
    let jobID = "1484074084916891649"
    let sweet = Sweet.exampleSweet()
    let compliance = try await sweet.fetchCompliance(jobID: jobID)
    
    print(compliance)
  }
  
  func testCreateCompliance() async throws {
    let sweet = Sweet.exampleSweet()
    let compliance = try await sweet.createCompliance(type: .users, name: "fds", resumable: nil)
    
    print(compliance)
  }
}
