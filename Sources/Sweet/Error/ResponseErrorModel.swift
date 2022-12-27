//
//  ResponseErrorModel.swift
//

import Foundation

extension Sweet {
  /// Error that includes API Error
  public struct ResponseErrorModel: Sendable {
    public let errors: [ResourceError]
    public let title: String
    public let detail: String
    public let type: String
    public let status: Int

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

      if !errors.isEmpty {
        return .responseError(errors: errors)
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

    let errors = try container.decodeIfPresent([Sweet.ErrorMessageModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []

    self.title = try container.decode(String.self, forKey: .title)
    self.detail = try container.decode(String.self, forKey: .detail)
    self.type = try container.decode(String.self, forKey: .type)
    self.status = try container.decode(Int.self, forKey: .status)
  }
}
