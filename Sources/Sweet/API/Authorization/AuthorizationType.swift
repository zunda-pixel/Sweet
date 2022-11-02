//
//  AuthorizationType.swift
//

import Foundation
import HTTPMethod
import OAuth1

extension Sweet {
  public enum AuthorizationType: Sendable {
    case oAuth2user(token: String)
    case oAuth2App(token: String)
    case oAuth1(accessToken: String, accessSecretToken: String, oAuth1Token: String, oAuth2SecretToken: String)
    
    func bearerToken(httpMethod: HTTPMethod, url: URL, queries: [String: String]) -> String {
      switch self {
      case .oAuth2App(let token): return "Bearer \(token)"
      case .oAuth2user(let token): return "Bearer \(token)"
      case .oAuth1(let accessToken, let accessSecretToken, let oAuthToken, let oAuthSecretToken):
        let oAuth1 = OAuth1(accessToken: accessToken, accessSecretToken: accessSecretToken, oAuthToken: oAuthToken, oAuthSecretToken: oAuthSecretToken, httpMethod: httpMethod, url: url, queries: queries)
        return oAuth1.bearerToken()
      }
    }
  }
}
