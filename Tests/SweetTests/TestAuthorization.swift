//
//  TestAuthorizationAPI.swift
//

import XCTest

@testable import OAuth1
@testable import Sweet

final class TestAuthorization: XCTestCase {
  let clientID = "ak1laUJKdGNIa21pTGFZXoisSjQ6MTpjaQ"
  let clientSecret = "FJcxPnw7P3aBv97HwGa3jid4H3UOzHc7WGxBXrbEFCg0oZ7ILy"

  let callbackURL = URL(string: "https://www.example.com/")!
  let challenge = "challenge"
  let state = "state"

  func testBasicAuthorization() {
    let apiKey = "xvz1evFS4wEEPTGEFPHBog"
    let apiSecret = "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"

    let basic = Sweet.getBasicAuthorization(id: apiKey, password: apiSecret)

    XCTAssertEqual(
      basic,
      "eHZ6MWV2RlM0d0VFUFRHRUZQSEJvZzpMOHFxOVBaeVJnNmllS0dFS2hab2xHQzB2SldMdzhpRUo4OERSZHlPZw==")
  }

  func testGetAppBearerToken() async throws {
    let apiKey = "mQMFhgaJH45lp3q0sK2TJJEKv"
    let apiSecret = "BsN6fbfDTq61BPyPovPeILjdieP4JjG4b6Ha6mNBShaMdJSVvc"

    let appBearerToken = try await Sweet.getAppBearerToken(apiKey: apiKey, apiSecretKey: apiSecret)

    print(appBearerToken)
  }

  func testAuthorizationURL() {
    let oauth2 = Sweet.OAuth2(
      clientID: clientID,
      clientSecret: clientSecret,
      configuration: .default
    )

    let authorizeURL = oauth2.getAuthorizeURL(
      scopes: Sweet.AccessScope.allCases, callBackURL: callbackURL, challenge: challenge,
      state: state)

    print(authorizeURL)
  }

  func testGetUserBearerToken() async throws {
    let code =
      "SjJBWDVtakZoa3E5RGJOSms1aHpiVDZGVkxhdV9vOUhmcVRJUEdGZVV1X25nOjE2NjUzNTE2OTA5MDI6MTowOmFjOjE"

    let oauth2 = Sweet.OAuth2(
      clientID: clientID,
      clientSecret: clientSecret,
      configuration: .default
    )

    let response = try await oauth2.getUserBearerToken(
      code: code, callBackURL: callbackURL, challenge: challenge)

    print(response)
  }

  func testGetUserBearerTokenWithRefreshToken() async throws {
    let refreshToken =
      "LW13RzJtRVplVTRPZUFjTTY4MUFCVGFKdzB2ZzJodHJwcVdDejJIMVZxU0JIOjE2NjUzNTE3MDY3MTg6MTowOnJ0OjE"

    let oauth2 = Sweet.OAuth2(
      clientID: clientID,
      clientSecret: clientSecret,
      configuration: .default
    )

    let response = try await oauth2.refreshUserBearerToken(with: refreshToken)

    print(response)
  }

  func testOAuth1AuthorizationURL() async throws {
    let oAuth1 = OAuth1(
      accessToken: "k1KVviIOklkmjyR6PUDWHrGUH",
      accessSecretToken: "v6OhT1iEYJYKHTsNfJpoWD0L7u2xw8pSLHRD2q0mNn1dvuTc28",
      httpMethod: .post,
      url: .init(string: "https://api.twitter.com/oauth/request_token")!
    )

    let twitterOAuth1 = Sweet.TwitterOAuth1(oAuth1: oAuth1)
    let url = try await twitterOAuth1.authenticateURL()
    print(url)
  }

  func testOAuth1BackedURL() async throws {
    let oAuthToken = "TietTt4hYg4MYIqSFjYe8O4PYGW"
    let oAuthVerifier = "gg4PteXMwK2u2C8wwLRqeFTitlqxD46q"

    let response = try await Sweet.TwitterOAuth1.accessToken(
      oAuthToken: oAuthToken, oAuthVerifier: oAuthVerifier)

    print(response)
  }
}
