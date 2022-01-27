//
//  Oauth2.swift
//  
//
//  Created by zunda on 2022/01/20.
//

import Foundation
import HTTPClient

struct TwitterOauth2 {
  let clientID: String
  let clientSecretKey: String
  
  func getAuthorizeURL(url: URL, scopes: [TwitterScope], callBackURL: URL, challenge: String) -> URL {
    // https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
    
    let joinedScope = scopes.map { $0.rawValue }.joined(separator: " ")
    
    let queries = [
      "response_type": "code",
      "client_id": clientID,
      "redirect_uri": callBackURL.absoluteString,
      "scope": joinedScope,
      "state": "state",
      "code_challenge": challenge,
      "code_challenge_method": "plain",
    ]
    
    var urlComponents: URLComponents = .init(url: url, resolvingAgainstBaseURL: true)!
    urlComponents.queryItems = queries.map { .init(name: $0, value: $1)}
    
    return urlComponents.url!
  }
  
  func getCode(from url: URL) -> String {
    // https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
    
    let urlComponents: URLComponents = .init(url: url, resolvingAgainstBaseURL: true)!
    let code = urlComponents.queryItems?.first(where: {$0.name == "code"})?.value
    return code!
  }

  
  func getUserBearerToken(code: String, url: URL, callBackURL: URL, challenge: String) async throws -> (String, String) {
    // https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token
    
    let basicAuthorization = getBasicAuthorization(user: clientID, password: clientSecretKey)
        
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
        
    let (data, _) = try await HTTPClient.post(url: url, headers: headers, queries: queries)
        
    let twitterOauth2Response = try JSONDecoder().decode(Oauth2ModelResponse.self, from: data)
        
    return (twitterOauth2Response.bearerToken, twitterOauth2Response.refleshToken)
  }
  
  func getRefreshUserBearerToken(refleshToken: String) async throws -> (String, String) {
    // https://developer.twitter.com/en/docs/authentication/oauth-2-0/authorization-code
    
    let url: URL = .init(string: "https://api.twitter.com/2/oauth2/token")!
      
    let queries = [
      "refresh_token": refleshToken,
      "grant_type": "refresh_token",
      "client_id": clientID,
    ]
        
    let (data, _) = try await HTTPClient.post(url: url, queries: queries)
    
    let twitterOauth2Response = try JSONDecoder().decode(Oauth2ModelResponse.self, from: data)
        
    return (twitterOauth2Response.bearerToken, twitterOauth2Response.refleshToken)
  }
  
  func getBasicAuthorization(user: String, password: String) -> String {
    let value = "\(user):\(password)"
    let encodedValue = value.data(using: .utf8)!
    let endoded64Value = encodedValue.base64EncodedString()
    return endoded64Value
  }
}

struct Oauth2ModelResponse: Decodable {
  public let bearerToken: String
  public let refleshToken: String
  
  private enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refleshToken = "refresh_token"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.bearerToken = try values.decode(String.self, forKey: .accessToken)
    self.refleshToken = try values.decode(String.self, forKey: .refleshToken)
  }
}
