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
  }
  
  enum InternalResourceError: Error, Sendable {
    case noResource
  }
}
