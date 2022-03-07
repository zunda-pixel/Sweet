//
//  SearchTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

public enum SortOrder: String {
  case recency
  case relevancy
}

extension Sweet {
  public func searchRecentTweet(by query: String, maxResults: Int = 10,
                                startTime: Date? = nil, endTime: Date? = nil,
                                untilID: String? = nil, sinceID: String? = nil,
                                sortOrder: SortOrder? = nil, nextToken: String? = nil,
                                tweetFields: [TweetField] = [], userFields: [UserField] = [],
                                mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> [TweetModel] {
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
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let formatter = TwitterDateFormatter()

    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedNilValueQueries: [String: String?] = queries.filter { $0.value != nil }
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: removedNilValueQueries)
            
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  public func searchTweet(by query: String, maxResults: Int = 10,
                          startTime: Date? = nil, endTime: Date? = nil,
                          untilID: String? = nil, sinceID: String? = nil,
                          sortOrder: SortOrder? = nil, nextToken: String? = nil,
                          tweetFields: [TweetField] = [], userFields: [UserField] = [],
                          mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> [TweetModel] {
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
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
     
    let formatter = TwitterDateFormatter()
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedNilValueQueries = queries.filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: removedNilValueQueries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}
