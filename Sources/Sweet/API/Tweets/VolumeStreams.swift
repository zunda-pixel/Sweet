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
  /// Stream Volume Request
  /// - Parameters:
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: URLRequest
  public func volumeStreamRequest(backfillMinutes: Int? = nil) -> URLRequest {
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
      method: method,
      url: url,
      queries: removedEmptyQueries,
      headers: headers
    )
    return request
  }

  /// Stream Volume
  /// - Parameters:
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: AsyncThrowingStream<Result<Sweet.TweetResponse, any Error>, any Error>
  public func volumeStream(backfillMinutes: Int? = nil)
    -> AsyncThrowingStream<Result<Sweet.TweetResponse, any Error>, any Error>
  {
    let request = volumeStreamRequest(backfillMinutes: backfillMinutes)

    return AsyncThrowingStream { continuation in
      let stream = StreamExecution(request: request) { data in
        let stringData = String(data: data, encoding: .utf8)!
        let strings = stringData.split(whereSeparator: \.isNewline)
        let decoder = JSONDecoder.twitter

        for string in strings {
          let data = Data(string.utf8)

          if let response = try? decoder.decode(TweetResponse.self, from: data) {
            continuation.yield(.success(response))
            continue
          }

          if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
            continuation.yield(.failure(response.error))
            continue
          }

          let unknownError = UnknownError(request: request, data: data, response: nil)
          continuation.yield(.failure(unknownError))
        }
      } errorHandler: { error in
        continuation.finish(throwing: error)
      }

      continuation.onTermination = { @Sendable _ in
        stream.task.cancel()
      }

      stream.start()
    }
  }
}
