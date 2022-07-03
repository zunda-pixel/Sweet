//
//  TweetCounts.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

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
  public func fetchRecentCountTweet(query: String, startTime: Date? = nil,
                                    endTime: Date? = nil, untilID: String? = nil,
                                    sinceID: String? = nil, granularity: DateGranularity = .hour) async throws -> CountTweetResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-recent
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/recent")!
    
    var queries = [
      "query": query,
      "until_id": untilID,
      "since_id": sinceID,
      "granularity": granularity.rawValue,
    ]
    
    let formatter = TwitterDateFormatter()
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedEmptyQueries: [String: String?] = queries.filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: removedEmptyQueries)
    
    if let response = try? JSONDecoder().decode(CountTweetResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
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
  public func fetchCountTweet(query: String, nextToken: String? = nil,
                              startTime: Date? = nil, endTime: Date? = nil, untilID: String? = nil,
                              sinceID: String? = nil, granularity: DateGranularity = .hour) async throws -> CountTweetResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-all
    // This endpoint is only available for Academic Research access.
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/all")!
    
    var queries = [
      "query": query,
      "until_id": untilID,
      "since_id": sinceID,
      "granularity": granularity.rawValue,
      "next_token": nextToken,
    ]
    
    let formatter = TwitterDateFormatter()
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedEmptyQueries: [String: String?] = queries.filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: removedEmptyQueries)
    
    if let response = try? JSONDecoder().decode(CountTweetResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
