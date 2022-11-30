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
        return .forbidden
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
    let values = try decoder.container(keyedBy: CodingKeys.self)

    let messages = try values.decodeIfPresent([ErrorMessageModel].self, forKey: .errors)
    self.messages = messages?.map(\.message) ?? []

    self.title = try values.decode(String.self, forKey: .title)
    self.detail = try values.decode(String.self, forKey: .detail)
    self.type = try values.decode(String.self, forKey: .type)
    self.status = try values.decodeIfPresent(Int.self, forKey: .status)
  }
}
