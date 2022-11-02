//
//  VolumeStreams.swift
//

import Foundation
import HTTPClient
import HTTPMethod

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

    let method: HTTPMethod = .get

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

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    return request
  }
}
