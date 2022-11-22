//
//  TwitterError.swift
//

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Sweet {
  /// Twitter Error
  public enum TwitterError: Error, Sendable {
    case invalidRequest(error: Sweet.ResponseErrorModel)
    case unknown(request: URLRequest, data: Data, response: URLResponse)
    case followError
    case listMemberError

    case updateListError
    case deleteListError
    case pinnedListError

    case hideReplyError
    case likeTweetError
    case deleteTweetError
    case retweetError
    case blockUserError
    case muteUserError
    case bookmarkError
    case uploadCompliance

    // ex1: Authenticating with OAuth 1.0a User Context is forbidden for this endpoint.  Supported authentication types are [OAuth 2.0 Application-Only].
    // ex2: Authenticating with OAuth 2.0 Application-Only is forbidden for this endpoint.  Supported authentication types are [OAuth 1.0a User Context, OAuth 2.0 User Context].
    case unsupportedAuthentication(detail: String)

    case unAuthorized

    case forbidden
  }
}
