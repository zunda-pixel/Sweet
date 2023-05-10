//
//  FilteredStream.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Stream Rule with ids
  /// - Parameter ids: Stream Rule IDs
  /// - Returns: Stream Rules
  public func streamRule(ids: some Sequence<String> = []) async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!

    let queries: [String: String?] = [
      "ids": ids.joined(separator: ",")
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method,
      url: url,
      queries: removedEmptyQueries,
      headers: headers
    )

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(StreamRuleResponse.self, from: data) {
      return response.streamRules
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Fetch Stream Request
  /// - Parameters:
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: URLRequest
  public func filteredStreamRequest(backfillMinutes: Int? = nil) -> URLRequest {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream")!

    @DictionaryBuilder<String, String?>
    var queries: [String: String?] {
      [
        TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
        MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
        UserField.key: userFields.map(\.rawValue).joined(separator: ","),
        PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
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

  /// Fetch Stream
  /// - Parameters:
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: AsyncThrowingStream<Result<Sweet.TweetResponse, any Error>, any Error>
  public func filteredStream(backfillMinutes: Int? = nil)
    -> AsyncThrowingStream<Result<Sweet.TweetResponse, any Error>, any Error>
  {
    let request = filteredStreamRequest(backfillMinutes: backfillMinutes)

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

  /// Create Stream Rule
  /// - Parameters:
  ///   - streamRuleModels: Stream Rule Models
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  /// - Returns: StreamRuleModel
  public func createStreamRule(
    _ streamRuleModels: [StreamRuleModel],
    dryRun: Bool = false
  ) async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!

    let queries: [String: String] = [
      "dry_run": String(dryRun)
    ]

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: queries)

    let body = ["add": streamRuleModels]

    let bodyData = try JSONEncoder().encode(body)

    let request: URLRequest = .request(
      method: method,
      url: url,
      queries: queries,
      headers: headers,
      body: bodyData
    )

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(CreateStreamRuleResponse.self, from: data) {
      return response.streamRules
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Delete Stream Rules with IDs
  /// - Parameters:
  ///   - ids: Stream Rules ID
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  public func deleteStreamRule<S: Sequence>(
    ids: S,
    dryRun: Bool = false
  ) async throws where S.Element == String, S: Encodable {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!

    let queries: [String: String] = [
      "dry_run": String(dryRun)
    ]

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: queries)

    let body = ["delete": ["ids": ids]]

    let bodyData = try JSONEncoder().encode(body)

    let request: URLRequest = .request(
      method: method,
      url: url,
      queries: queries,
      headers: headers,
      body: bodyData
    )

    let _ = try await session.data(for: request)
  }

  /// Delete Stream Rules With Value
  /// - Parameters:
  ///   - values: Values
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  public func deleteStreamRule<Values: Sequence>(
    values: Values,
    dryRun: Bool = false
  ) async throws where Values.Element == String, Values: Encodable {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!

    let queries: [String: String] = [
      "dry_run": String(dryRun)
    ]

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: queries)

    let body = ["delete": ["values": values]]

    let bodyData = try JSONEncoder().encode(body)

    let request: URLRequest = .request(
      method: method,
      url: url,
      queries: queries,
      headers: headers,
      body: bodyData
    )

    let _ = try await session.data(for: request)
  }
}
