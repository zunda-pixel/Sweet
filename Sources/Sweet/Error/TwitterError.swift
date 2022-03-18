//
//  File.swift
//  
//
//  Created by zunda on 2022/03/14.
//

import Foundation

public enum TwitterError: Error {
  case invalidRequest(error: ResponseErrorModel)
  case unknwon(data: Data, response: URLResponse)
  case followError
  case listError
  case hiddenError
}
