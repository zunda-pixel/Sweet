//
//  ResponseErrorModel.swift
//
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  /// Error that includes API Error
  public struct ResponseErrorModel: Sendable {
    public let messages: [String]
    public let title: String
    public let detail: String
    public let type: String
    public let status: Int?

    private struct ErrorMessageModel: Decodable, Sendable {
      public let message: String
    }

    var error: TwitterError {
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

      return .invalidRequest(error: self)
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

    let messages = try container.decodeIfPresent([ErrorMessageModel].self, forKey: .errors)
    self.messages = messages?.map(\.message) ?? []

    self.title = try container.decode(String.self, forKey: .title)
    self.detail = try container.decode(String.self, forKey: .detail)
    self.type = try container.decode(String.self, forKey: .type)
    self.status = try container.decodeIfPresent(Int.self, forKey: .status)
  }
}
