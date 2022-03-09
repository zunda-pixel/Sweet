//
//  VolumeStreams.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchStreamVolume(delegate: URLSessionDataDelegate, backfillMinutes: Int? = nil,
                                tweetFields: [TweetField] = [], mediaFields: [MediaField] = [], userFields: [UserField] = [],
                                pollFields: [PollField] = [], placeFields: [PlaceField] = []) -> URLSessionDataTask {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/volume-streams/api-reference/get-tweets-sample-stream
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/sample/stream")!
    
    let queries = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .App)
    
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    components.queryItems = queries.map { .init(name: $0, value: $1)}
    
    if let backfillMinutes = backfillMinutes {
      let queries = ["backfill_minutes": String(backfillMinutes)]
      components.queryItems = queries.map { .init(name: $0, value: $1) }
    }

    var request = URLRequest(url: components.url!)
    request.allHTTPHeaderFields = headers
    
    let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    return session.dataTask(with: request)
  }
}
