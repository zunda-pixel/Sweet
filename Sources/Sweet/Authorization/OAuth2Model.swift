//
//  OAuth2Model.swift
//

import Foundation

extension Sweet {
  public struct OAuth2Model {
    public let bearerToken: String
    public let refreshToken: String?
    public let expiredSeconds: Int
  }
}

extension Sweet.OAuth2Model: Decodable {
  private enum CodingKeys: String, CodingKey {
    case bearerToken = "access_token"
    case refreshToken = "refresh_token"
    case expiredSeconds = "expires_in"
  }
}
