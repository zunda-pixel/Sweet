//
//  ResponseErrorModel.swift
//

import Foundation

extension Sweet {
  public enum RequestError: Error, Sendable {
    case accountLocked
    case forbidden(detail: String)
    case tooManyAccess
    case unAuthorized
    case unsupportedAuthentication(detail: String)
    case invalidRequest(response: ResponseErrorModel)
  }

  /// Error that includes API Error
  public struct ResponseErrorModel: Sendable {
    public let errors: [ResponseErrorMessage]
    public let title: String
    public let detail: String
    public let type: URL
    public let status: Int?

    var error: RequestError {
      if detail
        == "Your account is temporarily locked. Please log in to https://twitter.com to unlock your account."
      {
        return .accountLocked
      }

      if title == "Forbidden" {
        return .forbidden(detail: detail)
      }

      if title == "Too Many Requests" {
        return .tooManyAccess
      }

      if title == "Unauthorized" {
        return .unAuthorized
      }

      if title == "Unsupported Authentication" {
        return .unsupportedAuthentication(detail: detail)
      }

      return .invalidRequest(response: self)
    }
  }
}

extension Sweet.ResponseErrorModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case errors
    case title
    case detail
    case type
    case status
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.title = try container.decode(String.self, forKey: .title)
    self.detail = try container.decode(String.self, forKey: .detail)
    self.type = try container.decode(URL.self, forKey: .type)
    self.status = try container.decodeIfPresent(Int.self, forKey: .status)
    let errors = try container.decodeIfPresent([Sweet.ResponseErrorMessage].self, forKey: .errors)
    self.errors = errors ?? []
  }
}
