//
//  TestTwitterOauth2.swift
//  
//
//  Created by zunda on 2022/01/20.
//

import XCTest
@testable import Sweet

final class TestTwitterOauth2: XCTestCase {
  let challenge: String = "challenge"
  
  func exampleTwitterOauth() -> TwitterOauth2 {
    let clientID        = "ak1laUJKdGNIa21pTGFZX3A2SjQ6MTpjaQ"
    let clientSecretKey = "iLMwWggINLUg_fnWKHKMXp5zjSQLbX8OQes_Gru4b3dSynn1Lo"
    return TwitterOauth2(clientID: clientID, clientSecretKey: clientSecretKey)
  }
  
  func testGetAuthorizeURL() {
    let callBackURL:URL = .init(string: "http://localhost:8000")!
    let authorizeURL: URL = .init(string: "https://twitter.com/i/oauth2/authorize")!
    
    let twitterOauth2 = exampleTwitterOauth()
    let url = twitterOauth2.getAuthorizeURL(url: authorizeURL, scopes: TwitterScope.allCases, callBackURL: callBackURL, challenge: challenge)
    
    print(url)
  }
  
  func testGetCode() {
    let url: URL = .init(string: "http://localhost:8000/?state=state&code=d0M2RXJsYmszXzNLbEpoX2JxUV9vd3R1WEFkNXJNS0tpRFl6TWVVLWtQX0ZROjE2NDI2ODc1MDg4MTg6MToxOmFjOjE")!
    
    let twitterOauth2 = exampleTwitterOauth()
    let code = twitterOauth2.getCode(from: url)
    print(code)
  }
  
  func testGetUserBearerToken() async throws {
    let code = "Z0FXdDJaUUQ1XzNpRkxoY0xfLTJiaXJ1clltQU9SY0htOEpCR3cxNkY1Y3VrOjE2NDI3NzY0MzU3MDI6MTowOmFjOjE"
    
    let authorizeURL: URL = .init(string: "https://api.twitter.com/2/oauth2/token")!
    let callBackURL: URL = .init(string: "http://localhost:8000")!
    
    let twitterOauth2 = exampleTwitterOauth()
    let (bearerToken, scopes) = try await twitterOauth2.getUserBearerToken(code: code, url: authorizeURL, callBackURL: callBackURL, challenge: challenge)
    
    print(bearerToken)
    print(scopes)
  }
}
