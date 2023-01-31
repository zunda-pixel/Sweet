//
//  AuthorizationError.swift
//

import Foundation

extension Sweet {
  public enum AuthorizationError: Error {
    case invalidClient
    case invalidRequest
    case unknown(response: AuthorizationErrorResponse)
  }
}

extension Sweet {
  public struct AuthorizationErrorResponse: Decodable {
    public let error: String
    public let errorDescription: String
    
    var authorizationError: Sweet.AuthorizationError {
      if error == "invalid_client" {
        return .invalidClient
      }
      
      if error == "invalid_request" {
        return .invalidRequest
      }
      
      return .unknown(response: self)
    }
    
    private enum CodingKeys: String, CodingKey {
      case error
      case errorDescription = "error_description"
    }
  }
}
