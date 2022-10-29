//
//  VolumeStreams.swift
//
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Sweet {
  /// Stream Volume
  /// - Parameters:
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: URLRequest
  public func streamVolumeRequest(backfillMinutes: Int? = nil)
    -> URLRequest
  {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/volume-streams/api-reference/get-tweets-sample-stream

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/sample/stream")!

    @DictionaryBuilder<String, String?>
    var queries: [String: String?] {
      [
        TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
        UserField.key: userFields.map(\.rawValue).joined(separator: ","),
        PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
        MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
        PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
        Expansion.key: allTweetExpansion.joined(separator: ","),
      ]

      if let backfillMinutes {
        ["backfill_minutes": String(backfillMinutes)]
      }
    }

    let emptyRemovedQueries = queries.filter { $0.value != nil && !$0.value!.isEmpty }

    let headers = getBearerHeaders(type: .app)

    let request = URLRequest.get(url: url, headers: headers, queries: emptyRemovedQueries)

    return request
  }
}
