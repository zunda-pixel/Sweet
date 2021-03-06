//
//  SearchTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Search Tweets that Tweeted Recent by Query
  /// - Parameters:
  ///   - query: Search Query
  ///   - maxResults: Max Tweet Count
  ///   - startTime: Start Time
  ///   - endTime: End Time
  ///   - untilID: Return Tweet ID less than (that is, older than) the specified ID
  ///   - sinceID: Return Tweet ID greater than (that is, more recent than) the specified ID
  ///   - sortOrder: Sort Order Type
  ///   - nextToken: This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
  /// - Returns: Tweets
  public func searchRecentTweet(query: String, maxResults: Int = 100, startTime: Date? = nil, endTime: Date? = nil,
                                untilID: String? = nil, sinceID: String? = nil, sortOrder: SortOrder? = nil,
                                nextToken: String? = nil) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/recent")!
    
    var queries: [String: String?] = [
      "query": query,
      "max_results": String(maxResults),
      "until_id": untilID,
      "since_id": sinceID,
      "next_token": nextToken,
      "sort_order": sortOrder?.rawValue,
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let formatter = TwitterDateFormatter()
    
    if let startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedEmptyQueries: [String: String?] = queries.filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: authorizeType)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: removedEmptyQueries)
    
    if let response = try? JSONDecoder().decode(TweetsResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Search Tweets By Query
  /// - Parameters:
  ///   - query: Search Query
  ///   - maxResults: Max Tweet Count
  ///   - startTime: Start Time
  ///   - endTime: End Time
  ///   - untilID: Return Tweet ID less than (that is, older than) the specified ID
  ///   - sinceID: Return Tweet ID greater than (that is, more recent than) the specified ID
  ///   - sortOrder: Sort Order Type
  ///   - nextToken: This parameter is used to get the next 'page' of results.
  ///   The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
  /// - Returns: Tweets
  public func searchTweet(query: String, maxResults: Int = 500,
                          startTime: Date? = nil, endTime: Date? = nil,
                          untilID: String? = nil, sinceID: String? = nil,
                          sortOrder: SortOrder? = nil, nextToken: String? = nil) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
    // This endpoint is only available for Academic Research access.
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/all")!
    
    var queries: [String: String?] = [
      "query": query,
      "max_results": String(maxResults),
      "until_id": untilID,
      "since_id": sinceID,
      "next_token": nextToken,
      "sort_order": sortOrder?.rawValue,
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let formatter = TwitterDateFormatter()
    
    if let startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedEmptyQueries = queries.filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: removedEmptyQueries)
    
    if let response = try? JSONDecoder().decode(TweetsResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
