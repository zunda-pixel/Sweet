//
//  ResponseErrorModel.swift
//

import Foundation

extension Sweet {
  public struct ErrorMessageModel: Decodable, Sendable {
    public let parameter: String?
    public let resourceID: String?
    public let value: String?
    public let detail: String?
    public let title: String?
    public let resourceType: String?
    public let type: String?

    enum CodingKeys: String, CodingKey {
      case parameter
      case resourceID = "resource_id"
      case value
      case detail
      case title
      case resourceType = "resource_type"
      case type
    }

    var error: ResourceError {
      if detail?.hasPrefix("User has been suspended") == true {
        return .userSuspend(userID: resourceID!)
      }

      if detail?.hasPrefix("Could not find user") == true {
        return .notFoundUser(userID: resourceID!)
      }

      if detail?.hasPrefix("Could not find tweet") == true {
        return .notFoundTweet(tweetID: resourceID!)
      }

      if detail?.hasPrefix("Could not find list") == true {
        return .notFoundList(listID: resourceID!)
      }

      if detail?.hasPrefix("Could not find space") == true {
        return .notFoundSpace(spaceID: resourceID!)
      }

      if detail?.hasPrefix("Sorry, you are not authorized to see the Tweet") == true {
        return .notAuthorizedToSeeTweet(tweetID: resourceID!)
      }

      return .unknown(self)
    }
  }

  /// Error that includes API Error
  public struct ResponseErrorModel: Sendable {
    public let errors: [ResourceError]
    public let title: String?
    public let detail: String?
    public let type: String?
    public let status: Int?

    var error: TwitterError {
      if detail
        == "Your account is temporarily locked. Please log in to https://twitter.com to unlock your account."
      {
        return .accountLocked
      }

      if title == "Forbidden" {
        return .forbidden(detail: detail!)
      }

      if title == "Too Many Requests" {
        return .tooManyAccess
      }

      if title == "Unauthorized" {
        return .unAuthorized
      }

      if title == "Unsupported Authentication" {
        return .unsupportedAuthentication(detail: detail!)
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
    self.errors =  errors?.map(\.error) ?? []

    self.title = try container.decodeIfPresent(String.self, forKey: .title)
    self.detail = try container.decodeIfPresent(String.self, forKey: .detail)
    self.type = try container.decodeIfPresent(String.self, forKey: .type)
    self.status = try container.decodeIfPresent(Int.self, forKey: .status)
  }
}
