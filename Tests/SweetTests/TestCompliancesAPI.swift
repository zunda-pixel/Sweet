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
    let type: Sweet.JobType = .tweets
    
    let compliances = try await Sweet.test.fetchCompliances(type: type)
    
    compliances.forEach {
      print($0)
    }
  }
  
  func testFetchCompliance() async throws {
    let jobID = "1484074084916891649"
    let compliance = try await Sweet.test.fetchCompliance(jobID: jobID)
    
    print(compliance)
  }
  
  func testCreateCompliance() async throws {
    let compliance = try await Sweet.test.createCompliance(type: .users, name: "fds", resumable: nil)
    
    print(compliance)
  }
}
