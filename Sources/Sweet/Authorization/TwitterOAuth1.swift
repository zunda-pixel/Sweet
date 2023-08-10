//
//  TwitterOAuth1.swift
//

import Foundation
import OAuth1

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  public struct TwitterOAuth1 {
    private let oAuth1: OAuth1

    public init(oAuth1: OAuth1) {
      self.oAuth1 = oAuth1
    }

    private func authorizationToken(authorization: String) async throws -> String {
      var request = URLRequest(url: oAuth1.url)
      request.httpMethod = oAuth1.httpMethod.rawValue
      request.allHTTPHeaderFields = ["Authorization": authorization]

      let (data, _) = try await URLSession.shared.data(for: request)

      let stringData = String(decoding: data, as: UTF8.self)

      let values = stringData.split(separator: "&").reduce(into: [String: String]()) {
        partialResult, next in
        let values: [String] = next.split(separator: "=").map { String($0) }
        partialResult[values[0]] = values[1]
      }

      return values["oauth_token"]!
    }

    public func authenticateURL() async throws -> URL {
      let authorization = oAuth1.authorization()
      let token = try await authorizationToken(authorization: authorization)

      let authenticateURL = "https://api.twitter.com/oauth/authenticate"
      var components = URLComponents(string: authenticateURL)!
      components.queryItems = [.init(name: "oauth_token", value: token)]
      return components.url!
    }

    static public func accessToken(oAuthToken: String, oAuthVerifier: String) async throws
      -> OAuth1Response
    {
      let parameters = [
        "oauth_token": oAuthToken,
        "oauth_verifier": oAuthVerifier,
      ]

      var components = URLComponents(string: "https://api.twitter.com/oauth/access_token")!
      components.queryItems = parameters.map { .init(name: $0.key, value: $0.value) }

      let request = URLRequest(url: components.url!)

      let (data, _) = try await URLSession.shared.data(for: request)

      let stringData = String(decoding: data, as: UTF8.self)

      let values = stringData.split(separator: "&").reduce(into: [String: String]()) {
        partialResult, next in
        let values: [String] = next.split(separator: "=").map { String($0) }
        partialResult[values[0]] = values[1]
      }

      let response = OAuth1Response(
        oAuthToken: values["oauth_token"]!,
        oAuthSecretToken: values["oauth_token_secret"]!,
        userID: values["user_id"]!,
        screenName: values["screen_name"]!)

      return response
    }

    public struct OAuth1Response {
      public let oAuthToken: String
      public let oAuthSecretToken: String
      public let userID: String
      public let screenName: String
    }
  }
}
