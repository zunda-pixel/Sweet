//
//  OAuth2.swift
//

import Foundation

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  public struct OAuth2 {
    let clientID: String
    let clientSecret: String

    let configuration: URLSessionConfiguration

    public init(
      clientID: String,
      clientSecret: String,
      configuration: URLSessionConfiguration
    ) {
      self.clientID = clientID
      self.clientSecret = clientSecret
      self.configuration = configuration
    }

    /// Get Authorize URL
    /// https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
    /// - Parameters:
    ///   - scopes: Access Scope
    ///   - callBackURL: callBack URL
    ///   - challenge: random value
    ///   - state: random value
    /// - Returns: Authorize URL
    public func getAuthorizeURL(
      scopes: [AccessScope], callBackURL: URL, challenge: String, state: String
    ) -> URL {
      let joinedScope = scopes.map(\.rawValue).joined(separator: " ")

      let queries = [
        "response_type": "code",
        "client_id": clientID,
        "redirect_uri": "\(callBackURL)",
        "scope": joinedScope,
        "state": state,
        "code_challenge": challenge,
        "code_challenge_method": "plain",
      ]

      let authorizationURL: URL = .init(string: "https://twitter.com/i/oauth2/authorize")!

      let request = URLRequest.get(url: authorizationURL, queries: queries)

      return request.url!
    }

    /// Get User Bearer Token
    /// https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
    /// - Parameters:
    ///   - code: code of CallBacked URL's query
    ///   - callBackURL: callBack URL
    ///   - challenge: random value
    /// - Returns: OAuth2Model
    public func getUserBearerToken(code: String, callBackURL: URL, challenge: String) async throws
      -> OAuth2Model
    {
      let url: URL = .init(string: "https://api.twitter.com/2/oauth2/token")!

      let basicAuthorization = Sweet.getBasicAuthorization(id: clientID, password: clientSecret)

      let headers = [
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic \(basicAuthorization)",
      ]

      let queries = [
        "code": code,
        "grant_type": "authorization_code",
        "client_id": clientID,
        "redirect_uri": callBackURL.absoluteString,
        "code_verifier": challenge,
      ]

      let request: URLRequest = .post(url: url, headers: headers, queries: queries)

      let session = URLSession(configuration: configuration)

      let (data, urlResponse) = try await session.data(for: request)

      let decoder = JSONDecoder()

      if let response = try? decoder.decode(OAuth2Model.self, from: data) {
        return response
      }

      if let response = try? decoder.decode(Sweet.ResponseErrorModel.self, from: data) {
        throw response.error
      }

      throw UnknownError(request: request, data: data, response: urlResponse)
    }

    /// Refresh User Bearer Token
    /// https://developer.twitter.com/en/docs/authentication/oauth-2-0/authorization-code
    /// - Parameter refreshToken: Refresh Token
    /// - Returns: OAuth2Model
    public func refreshUserBearerToken(with refreshToken: String) async throws -> OAuth2Model {
      let url: URL = .init(string: "https://api.twitter.com/2/oauth2/token")!

      let queries = [
        "refresh_token": refreshToken,
        "grant_type": "refresh_token",
        "client_id": clientID,
      ]

      let request: URLRequest = .post(url: url, queries: queries)

      let session = URLSession(configuration: configuration)

      let (data, urlResponse) = try await session.data(for: request)

      let decoder = JSONDecoder()

      if let response = try? decoder.decode(OAuth2Model.self, from: data) {
        return response
      }

      if let response = try? decoder.decode(Sweet.AuthorizationErrorResponse.self, from: data) {
        throw response.authorizationError
      }

      throw UnknownError(request: request, data: data, response: urlResponse)
    }
  }
}
