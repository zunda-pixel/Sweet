//
//  ResponseErrorModel.swift
//

import Foundation

extension Sweet {
  /// Error that includes API Error
  public struct ResponseErrorModel: Sendable {
    public let errors: [DataError]
    public let title: String?
    public let detail: String?
    public let type: String?
    public let status: Int?
    
    public enum DataError: Sendable {
      case userSuspend(userID: String)
      case notFoundUser(userID: String)
      case unknown(ErrorMessageModel)
    }

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
      
      var error: DataError {
        if detail?.hasPrefix("User has been suspended") == true {
          return .userSuspend(userID: value!)
        }
        
        if detail?.hasPrefix("Could not find user") == true {
          return .notFoundUser(userID: value!)
        }
        
        return .unknown(self)
      }
    }

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

    let errors = try container.decodeIfPresent([ErrorMessageModel].self, forKey: .errors)
    self.errors =  errors?.map(\.error) ?? []

    self.title = try container.decodeIfPresent(String.self, forKey: .title)
    self.detail = try container.decodeIfPresent(String.self, forKey: .detail)
    self.type = try container.decodeIfPresent(String.self, forKey: .type)
    self.status = try container.decodeIfPresent(Int.self, forKey: .status)
  }
}
