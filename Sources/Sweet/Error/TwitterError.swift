//
//  TwitterError.swift
//  
//
//  Created by zunda on 2022/03/14.
//

import Foundation

extension Sweet {
  /// Twitter Error
  public enum TwitterError: Error {
    case invalidRequest(error: Sweet.ResponseErrorModel)
    case unknown(data: Data, response: URLResponse)
    case followError
    case listError
    case hiddenError
    case likeError
    case deleteError
    case retweetError
    case blockError
    case muteError
    case bookmarkError
  }
}
