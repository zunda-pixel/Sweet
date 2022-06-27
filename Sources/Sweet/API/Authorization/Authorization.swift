//
//  Authorization.swift
//
//
//  Created by zunda on 2022/01/25.
//

import Foundation

extension Sweet {
  public func getAuthorizeToken(type: AuthorizeType) -> String {
    switch type {
      case .User:
        return bearerTokenUser
      case .App:
        return bearerTokenApp
    }
  }
  
  public func getBearerHeaders(type: AuthorizeType) -> [String: String] {
    let bearerToken = getAuthorizeToken(type: type)
    
    let headers = [
      "Authorization": "Bearer \(bearerToken)",
       "Content-type": "application/json"
    ]
    
    return headers
  }
}
