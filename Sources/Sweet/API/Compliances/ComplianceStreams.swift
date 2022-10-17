//
//  ComplianceStreams.swift
//

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Sweet {
  /// Stream User Compliance
  /// https://developer.twitter.com/en/docs/twitter-api/compliance/streams/api-reference/get-users-compliance-stream
  /// - Parameters:
  ///   - partition: Must be set to 1, 2, 3 or 4. User compliance events are split across 4 partitions, so 4 separate streams are needed to receive all events.
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: URLRequest
  public func streamUsersCompliance(
    partition: Int, backfillMinutes: Int? = nil, startTime: Date? = nil, endTime: Date? = nil
  ) -> URLRequest {
    let url: URL = .init(string: "https://api.twitter.com/2/users/compliance/stream")!

    let formatter = TwitterDateFormatter()

    @DictionaryBuilder<String, String?>
    var queries: [String: String?] {
      [
        "partition": String(partition)
      ]

      if let backfillMinutes {
        ["backfill_minutes": String(backfillMinutes)]
      }

      if let startTime {
        ["start_time": formatter.string(from: startTime)]
      }

      if let endTime {
        ["end_time": formatter.string(from: endTime)]
      }
    }

    let emptyRemovedQueries = queries.filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: .app)

    let request = URLRequest.get(url: url, headers: headers, queries: emptyRemovedQueries)

    return request
  }

  /// Stream Tweets Compliance
  /// https://developer.twitter.com/en/docs/twitter-api/compliance/streams/api-reference/get-tweets-compliance-stream
  /// - Parameters:
  ///   - partition: Must be set to 1, 2, 3 or 4. User compliance events are split across 4 partitions, so 4 separate streams are needed to receive all events.
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: URLRequest
  public func streamTweetsCompliance(
    partition: Int, backfillMinutes: Int? = nil, startTime: Date? = nil, endTime: Date? = nil
  )
    -> URLRequest
  {
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/compliance/stream")!

    let formatter = TwitterDateFormatter()

    @DictionaryBuilder<String, String?>
    var queries: [String: String?] {
      ["partition": String(partition)]

      if let backfillMinutes {
        ["backfill_minutes": String(backfillMinutes)]
      }

      if let startTime {
        ["start_time": formatter.string(from: startTime)]
      }

      if let endTime {
        ["end_time": formatter.string(from: endTime)]
      }
    }

    let emptyRemovedQueries = queries.filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: .app)

    let request = URLRequest.get(url: url, headers: headers, queries: emptyRemovedQueries)

    return request
  }
}
