//
//  TwitterError.swift
//  
//
//  Created by zunda on 2022/03/14.
//

import Foundation

extension Sweet {
  public enum TwitterError: Error {
    case invalidRequest(error: Sweet.ResponseErrorModel)
    case unknwon(data: Data, response: URLResponse)
    case followError
    case listError
    case hiddenError
    case likeError
    case deleteError
    case retweetError
    case blockError
    case muteError
  }
}
