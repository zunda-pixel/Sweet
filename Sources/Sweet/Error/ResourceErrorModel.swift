//
//  ResourceErrorModel.swift
//

import Foundation

extension Sweet {
  public struct ResourceErrorModel: Decodable, Sendable {
    public let parameter: String?
    public let resourceID: String?
    public let value: String?
    public let detail: String
    public let title: String
    public let resourceType: String
    public let type: String
    public let section: String?
    public let field: String?

    enum CodingKeys: String, CodingKey {
      case parameter
      case resourceID = "resource_id"
      case value
      case detail
      case title
      case resourceType = "resource_type"
      case type
      case section
      case field
    }

    var error: ResourceError {
      if title == "Field Authorization Error" {
        return .fieldNotAuthorized(fields: field!)
      }

      if detail.hasPrefix("User has been suspended") == true {
        return .userSuspend(userID: resourceID!)
      }

      if detail.hasPrefix("Could not find user") == true {
        return .notFoundUser(userID: resourceID!)
      }

      if detail.hasPrefix("Could not find tweet") == true {
        return .notFoundTweet(tweetID: resourceID!)
      }

      if detail.hasPrefix("Could not find list") == true {
        return .notFoundList(listID: resourceID!)
      }

      if detail.hasPrefix("Could not find space") == true {
        return .notFoundSpace(spaceID: resourceID!)
      }

      if detail.hasPrefix("Sorry, you are not authorized to see the Tweet") == true {
        return .notAuthorizedToSeeTweet(tweetID: resourceID!)
      }

      return .unknown(self)
    }
  }
}
