//
//  VolumeStreams.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchStreamVolume(delegate: URLSessionDataDelegate) -> URLSessionDataTask {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/volume-streams/api-reference/get-tweets-sample-stream
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/sample/stream")!
    
    let headers = getBearerHeaders(type: .App)
    
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
    
    let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    return session.dataTask(with: request)
  }
}
