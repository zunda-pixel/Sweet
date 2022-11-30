//
//  TweetCounts.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Recent Tweet Count
  /// - Parameters:
  ///   - query: Query
  ///   - startTime: StartTime
  ///   - endTime: EndTime
  ///   - untilID: Return Tweet ID less than (that is, older than) the specified ID
  ///   - sinceID: Return Tweet ID greater than (that is, more recent than) the specified ID
  ///   - granularity: This is the granularity that you want the time series count data to be grouped by. You can request minute, hour, or day granularity. The default granularity, if not specified is hour.
  /// - Returns: TweetCount
  public func recentCountTweet(
    query: String, startTime: Date? = nil,
    endTime: Date? = nil, untilID: String? = nil,
    sinceID: String? = nil, granularity: DateGranularity = .hour
  ) async throws -> CountTweetResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-recent

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/recent")!

    let formatter = TwitterDateFormatter()

    @DictionaryBuilder<String, String?>
    var queries: [String: String?] {
      [
        "query": query,
        "until_id": untilID,
        "since_id": sinceID,
        "granularity": granularity.rawValue,
      ]

      if let startTime {
        ["start_time": formatter.string(from: startTime)]
      }

      if let endTime {
        ["end_time": formatter.string(from: endTime)]
      }
    }

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(CountTweetResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch Count Tweet
  /// - Parameters:
  ///   - query: Query
  ///   - nextToken: This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
  ///   - startTime: Start Time
  ///   - endTime: End Time
  ///   - untilID: Return Tweet ID less than (that is, older than) the specified ID
  ///   - sinceID: Return Tweet ID less than (that is, older than) the specified ID
  ///   - granularity: This is the granularity that you want the time series count data to be grouped by. You can request minute, hour, or day granularity. The default granularity, if not specified is hour.
  /// - Returns: TweetCount
  public func countTweet(
    query: String, nextToken: String? = nil,
    startTime: Date? = nil, endTime: Date? = nil, untilID: String? = nil,
    sinceID: String? = nil, granularity: DateGranularity = .hour
  ) async throws -> CountTweetResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-all
    // This endpoint is only available for Academic Research access.

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/all")!

    let formatter = TwitterDateFormatter()

    @DictionaryBuilder<String, String?>
    var queries: [String: String?] {
      [
        "query": query,
        "until_id": untilID,
        "since_id": sinceID,
        "granularity": granularity.rawValue,
        "next_token": nextToken,
      ]

      if let startTime {
        ["start_time": formatter.string(from: startTime)]
      }

      if let endTime {
        ["end_time": formatter.string(from: endTime)]
      }
    }

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(CountTweetResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
