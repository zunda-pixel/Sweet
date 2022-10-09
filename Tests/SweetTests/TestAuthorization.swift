//
//  TestAuthorizationAPI.swift
//

import XCTest
@testable import Sweet

final class TestAuthorization: XCTestCase {  
  func testBasicAuthorization() {
    let apiKey = "xvz1evFS4wEEPTGEFPHBog"
    let apiSecretKey = "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"
    
    let basic = Sweet.getBasicAuthorization(id: apiKey, password: apiSecretKey)
    
    XCTAssertEqual(basic, "eHZ6MWV2RlM0d0VFUFRHRUZQSEJvZzpMOHFxOVBaeVJnNmllS0dFS2hab2xHQzB2SldMdzhpRUo4OERSZHlPZw==")
  }
  
  func testGetAppBearerToken() async throws {
    let apiKey = "mQMFzgaJH85lp9q0sK2TJJEKv"
    let apiSecretKey = "BsN6fbfDTq61BPyPovPeILQ3BcP4JjG4b6Ha6mNBShaMdJSVvc"
    
    let appBearerToken = try await Sweet.getAppBearerToken(apiKey: apiKey, apiSecretKey: apiSecretKey)
    
    print(appBearerToken)
  }
}
