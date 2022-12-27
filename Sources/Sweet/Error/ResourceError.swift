//
//  ResourceError.swift
//

import Foundation

extension Sweet {
  public enum ResourceError: Sendable {
    case userSuspend(userID: String)
    case notFoundUser(userID: String)
    case notFoundTweet(tweetID: String)
    case notFoundList(listID: String)
    case notFoundSpace(spaceID: String)
    case notAuthorizedToSeeTweet(tweetID: String)
    case fieldNotAuthorized(fields: String)
    case unknown(Sweet.ErrorMessageModel)
  }
}
