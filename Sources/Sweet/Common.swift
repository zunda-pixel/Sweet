//
//  Common.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation


@available(macOS 12.0, iOS 13.0, *)
extension Sweet {
  var oauth1: Oauth1 {
    let oauth1 = Oauth1(consumerKey: consumerKey, consumerSecretKey: consumerSecretKey, oauthToken: oauthToken, oauthSecretToken: oauthSecretToken)
    return oauth1
  }
  
  var bearerHeaders: [String: String] {
    let headers = [
      "Authorization": "Bearer \(bearerToken)",
       "Content-type": "application/json"
    ]
    return headers
  }
  
  func getOauthHeaders(method: HTTPMethod, url: String) throws -> [String: String] {
    let authorization = try oauth1.getAuthorization(method: method, url: url)
    let headers = [
      "Authorization": authorization,
       "Content-type": "application/json"
    ]
    return headers
  }
}
