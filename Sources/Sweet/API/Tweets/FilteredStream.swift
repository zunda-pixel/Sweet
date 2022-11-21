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
  public func streamRule(ids: [String]? = nil) async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!

    let queries: [String: String?] = [
      "ids": ids?.joined(separator: ",")
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(StreamRuleResponse.self, from: data) {
      return response.streamRules
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch Stream
  /// - Parameters:
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: URLRequest
  public func streamTweetsRequest(backfillMinutes: Int? = nil)
    -> URLRequest
  {
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
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    return request
  }

  /// Create Stream Rule
  /// - Parameters:
  ///   - streamRuleModels: Stream Rule Models
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  /// - Returns: StreamRuleModel
  public func createStreamRule(_ streamRuleModels: [StreamRuleModel], dryRun: Bool = false)
    async throws -> [StreamRuleModel]
  {
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
      method: method, url: url, queries: queries, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder()

    if let response = try? decoder.decode(CreateStreamRuleResponse.self, from: data) {
      return response.streamRules
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Delete Stream Rules with IDs
  /// - Parameters:
  ///   - ids: Stream Rules ID
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  public func deleteStreamRule(ids: [String], dryRun: Bool = false) async throws {
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
      method: method, url: url, queries: queries, headers: headers, body: bodyData)

    let _ = try await session.data(for: request)
  }

  /// Delete Stream Rules With Value
  /// - Parameters:
  ///   - values: Values
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  public func deleteStreamRule(values: [String], dryRun: Bool = false) async throws {
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
      method: method, url: url, queries: queries, headers: headers, body: bodyData)

    let _ = try await session.data(for: request)
  }
}
