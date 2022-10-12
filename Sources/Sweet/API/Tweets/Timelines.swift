//
//  Timelines.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Fetch Recent Tweets and Retweets posted by you and users you follow.
  /// - Parameters:
  ///   - userID: User ID
  ///   - maxResults: Max Tweet Count
  ///   - startTime: Start Time
  ///   - endTime: End Time
  ///   - untilID: Return Tweet ID less than (that is, older than) the specified ID
  ///   - sinceID: Return Tweet ID greater than (that is, more recent than) the specified ID
  ///   - paginationToken: This parameter is used to get the next 'page' of results.
  ///   The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
  ///   - exclude: Exclude Tweet Type
  /// - Returns: Tweets
  public func fetchReverseChronological(userID: String, maxResults: Int = 100,
                                        startTime: Date? = nil, endTime: Date? = nil,
                                        untilID: String? = nil, sinceID: String? = nil,
                                        paginationToken: String? = nil, exclude: TweetExclude? = nil) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-reverse-chronological
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/timelines/reverse_chronological")!

    let formatter = TwitterDateFormatter()

    @DictionaryBuilder<String, String?>
    var queries: [String:  String?] {
      [
        "max_results": String(maxResults),
        "until_id": untilID,
        "since_id": sinceID,
        "pagination_token": paginationToken,
        "exclude": exclude?.rawValue,
        TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
        UserField.key: userFields.map(\.rawValue).joined(separator: ","),
        PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
        MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
        PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
        Expansion.key: allTweetExpansion.joined(separator: ","),
      ] as [String: String?]
      
      if let startTime {
        ["start_time": formatter.string(from: startTime)]
      }
      
      if let endTime {
        ["end_time": formatter.string(from: endTime)]
      }
    }
    
    let removedEmptyQueries: [String: String?] = queries.filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: removedEmptyQueries)
    
    if let response = try? JSONDecoder().decode(TweetsResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  /// Fetch Tweets composed by a single user, specified by the requested user ID.
  /// By default, the most recent ten Tweets are returned per request. Using pagination, the most recent 3,200 Tweets can be retrieved.
  /// - Parameters:
  ///   - userID: User ID
  ///   - maxResults: Max Tweet Count
  ///   - startTime: Start Time
  ///   - endTime: End Time
  ///   - untilID: Return Tweet ID less than (that is, older than) the specified ID
  ///   - sinceID: Return Tweet ID greater than (that is, more recent than) the specified ID
  ///   - paginationToken: This parameter is used to get the next 'page' of results.
  ///   The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
  ///   - exclude: Exclude Tweet Type
  /// - Returns: Tweets
  public func fetchTimeLine(userID: String, maxResults: Int = 100,
                            startTime: Date? = nil, endTime: Date? = nil,
                            untilID: String? = nil, sinceID: String? = nil,
                            paginationToken: String? = nil, exclude: TweetExclude? = nil) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/tweets")!
    
    let formatter = TwitterDateFormatter()

    @DictionaryBuilder<String, String?>
    var queries: [String:  String?] {
      [
        "max_results": String(maxResults),
        "until_id": untilID,
        "since_id": sinceID,
        "pagination_token": paginationToken,
        "exclude": exclude?.rawValue,
        TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
        UserField.key: userFields.map(\.rawValue).joined(separator: ","),
        PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
        MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
        PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
        Expansion.key: allTweetExpansion.joined(separator: ","),
      ] as [String: String?]
      
      if let startTime {
        ["start_time": formatter.string(from: startTime)]
      }
      
      if let endTime {
        ["end_time": formatter.string(from: endTime)]
      }
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
  
  /// Fetch Tweets mentioning a single user specified by the requested user ID. By default, the most recent ten Tweets are returned per request. Using pagination, up to the most recent 800 Tweets can be retrieved.
  
  /// - Parameters:
  ///   - userID: User ID
  ///   - maxResults: Max Tweet Count
  ///   - startTime: Start Time
  ///   - endTime: End Time
  ///   - untilID: Return Tweet ID less than (that is, older than) the specified ID
  ///   - sinceID: Return Tweet ID greater than (that is, more recent than) the specified ID
  ///   - paginationToken: This parameter is used to get the next 'page' of results.
  ///   The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.
  /// - Returns: Tweets
  public func fetchMentions(userID: String, maxResults: Int = 100,
                            startTime: Date? = nil, endTime: Date? = nil,
                            untilID: String? = nil, sinceID: String? = nil, paginationToken: String? = nil) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/mentions")!
    
    let formatter = TwitterDateFormatter()
    
    @DictionaryBuilder<String, String?>
    var queries: [String: String?] {
      [
        "max_results": String(maxResults),
        "until_id": untilID,
        "since_id": sinceID,
        "pagination_token": paginationToken,
        TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
        UserField.key: userFields.map(\.rawValue).joined(separator: ","),
        PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
        MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
        PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
        Expansion.key: allTweetExpansion.joined(separator: ","),
      ] as [String: String?]
      
      if let startTime {
        ["start_time": formatter.string(from: startTime)]
      }
      
      if let endTime {
        ["end_time": formatter.string(from: endTime)]
      }
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
}
