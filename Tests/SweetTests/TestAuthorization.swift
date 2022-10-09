//
//  TestAuthorizationAPI.swift
//

import XCTest
@testable import Sweet

final class TestAuthorization: XCTestCase {
  let clientID = "ak1laUJKdGNIa21pTGFZXoisSjQ6MTpjaQ"
  let clientSecret = "FJcxPnw7P3aBv97HwGa3jid4H3UOzHc7WGxBXrbEFCg0oZ7ILy"
  
  let callbackURL = URL(string: "https://www.example.com/")!
  let challenage = "challenge"
  let state = "state"
  
  func testBasicAuthorization() {
    let apiKey = "xvz1evFS4wEEPTGEFPHBog"
    let apiSecretKey = "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"
    
    let basic = Sweet.getBasicAuthorization(id: apiKey, password: apiSecretKey)
    
    XCTAssertEqual(basic, "eHZ6MWV2RlM0d0VFUFRHRUZQSEJvZzpMOHFxOVBaeVJnNmllS0dFS2hab2xHQzB2SldMdzhpRUo4OERSZHlPZw==")
  }
  
  func testGetAppBearerToken() async throws {
    let apiKey = "mQMFhgaJH45lp3q0sK2TJJEKv"
    let apiSecretKey = "BsN6fbfDTq61BPyPovPeILjdieP4JjG4b6Ha6mNBShaMdJSVvc"
    
    let appBearerToken = try await Sweet.getAppBearerToken(apiKey: apiKey, apiSecretKey: apiSecretKey)
    
    print(appBearerToken)
  }
  
  func testAuthorizationURL() {
    let oauth2 = Sweet.OAuth2(clientID: clientID, clientSecret: clientSecret)
    
    let authorizeURL = oauth2.getAuthorizeURL(scopes: Sweet.AccessScope.allCases, callBackURL: callbackURL, challenge: challenage, state: state)
    
    print(authorizeURL)
  }
  
  func testGetUserBearerToken() async throws {
    let code = "SjJBWDVtakZoa3E5RGJOSms1aHpiVDZGVkxhdV9vOUhmcVRJUEdGZVV1X25nOjE2NjUzNTE2OTA5MDI6MTowOmFjOjE"
    
    let oauth2 = Sweet.OAuth2(clientID: clientID, clientSecret: clientSecret)
    
    let response = try await oauth2.getUserBearerToken(code: code, callBackURL: callbackURL, challenge: challenage)
    
    print(response)
  }
  
  func testGetUserBearerTokenWithRefreshToken() async throws {
    let refreshToken = "LW13RzJtRVplVTRPZUFjTTY4MUFCVGFKdzB2ZzJodHJwcVdDejJIMVZxU0JIOjE2NjUzNTE3MDY3MTg6MTowOnJ0OjE"
    
    let oauth2 = Sweet.OAuth2(clientID: clientID, clientSecret: clientSecret)
    
    let response = try await oauth2.refreshUserBearerToken(with: refreshToken)
    
    print(response)
  }
}
