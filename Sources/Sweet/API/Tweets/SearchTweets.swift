//
//  SearchTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func searchRecentTweet(by query: String, fields: [TweetField] = [], maxResults: Int = 10,
                                startTime: Date? = nil, endTime: Date? = nil,
                                untilID: String? = nil, sinceID: String? = nil,
                                nextToken: String? = nil) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/recent")!
    
    var queries: [String: String?] = [
      "query": query,
      TweetField.key: fields.map(\.rawValue).joined(separator: ","),
      "max_results": String(maxResults),
      "until_id": untilID,
      "since_id": sinceID,
      "next_token": nextToken,
    ]
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
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
  
  public func searchTweet(by query: String, fields: [TweetField] = [], maxResults: Int = 10,
                          startTime: Date? = nil, endTime: Date? = nil,
                          untilID: String? = nil, sinceID: String? = nil,
                          nextToken: String? = nil) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
    // This endpoint is only available for Academic Research access.
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/all")!
    
    var queries: [String: String?] = [
      "query": query,
      TweetField.key: fields.map(\.rawValue).joined(separator: ","),
      "max_results": String(maxResults),
      "until_id": untilID,
      "since_id": sinceID,
      "next_token": nextToken,
    ]
     
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
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
