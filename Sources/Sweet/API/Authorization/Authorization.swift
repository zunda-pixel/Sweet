//
//  Authorization.swift
//
//
//  Created by zunda on 2022/01/25.
//

import Foundation

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  public func getAuthorizeToken(type: AuthorizeType) -> String {
    switch type {
    case .user:
      return bearerTokenUser
    case .app:
      return bearerTokenApp
    }
  }

  public func getBearerHeaders(type: AuthorizeType) -> [String: String] {
    let bearerToken = getAuthorizeToken(type: type)

    let headers = [
      "Authorization": "Bearer \(bearerToken)",
      "Content-type": "application/json",
    ]

    return headers
  }

  static func getBasicAuthorization(id: String, password: String) -> String {
    let allowedCharacter = CharacterSet.alphanumerics.union(.init(charactersIn: ";/?:@=&"))
    let encodedID = id.addingPercentEncoding(withAllowedCharacters: allowedCharacter)!
    let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: allowedCharacter)!
    let value = "\(encodedID):\(encodedPassword)"
    let encodedValue = value.data(using: .utf8)!
    let encoded64Value = encodedValue.base64EncodedString()
    return encoded64Value
  }

  static public func getAppBearerToken(
    apiKey: String, apiSecretKey: String, config: URLSessionConfiguration = .default
  ) async throws -> String {
    let basicAuthorization = Sweet.getBasicAuthorization(id: apiKey, password: apiSecretKey)

    let headers = [
      "Authorization": "Basic \(basicAuthorization)"
    ]

    let queries = [
      "grant_type": "client_credentials"
    ]

    let url = URL(string: "https://api.twitter.com/oauth2/token")!

    let (data, _) = try await URLSession(configuration: config).data(
      for: .post(url: url, headers: headers, queries: queries))

    let appBearerToken = try JSONDecoder().decode(AppBearerToken.self, from: data)

    return appBearerToken.accessToken
  }

  struct AppBearerToken: Codable {
    let tokenType: String
    let accessToken: String

    private enum CodingKeys: String, CodingKey {
      case tokenType = "token_type"
      case accessToken = "access_token"
    }
  }
}
