//
//  OAuth2.swift
//

import Foundation

extension Sweet {
  public struct OAuth2 {
    let clientID: String
    let clientSecret: String
    
    let configuration: URLSessionConfiguration
    
    public init(clientID: String, clientSecret: String, configuration: URLSessionConfiguration = .default) {
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
    /// - Returns: AUthorize URL
    public func getAuthorizeURL(scopes: [AccessScope], callBackURL: URL, challenge: String, state: String) -> URL {
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
      var urlComponents: URLComponents = .init(url: authorizationURL, resolvingAgainstBaseURL: true)!
      urlComponents.queryItems = queries.map { .init(name: $0, value: $1) }
      
      return urlComponents.url!
    }
    
    /// Get User Bearer Token
    /// https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
    /// - Parameters:
    ///   - code: code of Callbacked URL's query
    ///   - callBackURL: callBack URL
    ///   - challenge: randam value
    /// - Returns: OAuth2Model
    public func getUserBearerToken(code: String, callBackURL: URL, challenge: String) async throws -> OAuth2Model {
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
      
      let (data, urlResponse) = try await URLSession(configuration: configuration).post(
        url: url,
        headers: headers,
        queries: queries
      )
      
      if let response = try? JSONDecoder().decode(OAuth2Model.self, from: data) {
        return response
      }
      
      if let response = try? JSONDecoder().decode(Sweet.ResponseErrorModel.self, from: data) {
        throw Sweet.TwitterError.invalidRequest(error: response)
      }
      
      throw Sweet.TwitterError.unknown(data: data, response: urlResponse)
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
      
      let (data, urlResponse) = try await URLSession(configuration: configuration).post(url: url, queries: queries)
      
      if let response = try? JSONDecoder().decode(OAuth2Model.self, from: data) {
        return response
      }
      
      if let response = try? JSONDecoder().decode(Sweet.ResponseErrorModel.self, from: data) {
        throw Sweet.TwitterError.invalidRequest(error: response)
      }
      
      throw Sweet.TwitterError.unknown(data: data, response: urlResponse)
    }
  }
}