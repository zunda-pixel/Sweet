//
//  TweetCounts.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchRecentCountTweet(by query: String, startTime: Date? = nil, endTime: Date? = nil, untilID: String? = nil, sinceID: String? = nil, granularity: DateGranularity = .hour) async throws -> [CountTweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-recent
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/recent")!
    
    var queries = [
      "query": query,
      "until_id": untilID,
      "since_id": sinceID,
      "granularity": granularity.rawValue,
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
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: removedNilValueQueries)
    
    let countTweetResponseModel = try JSONDecoder().decode(CountTweetResponseModel.self, from: data)
    
    return countTweetResponseModel.countTweetModels
  }
  
  public func fetchCountTweet(by query: String, nextToken: String? = nil, startTime: Date? = nil, endTime: Date? = nil, untilID: String? = nil, sinceID: String? = nil, granularity: DateGranularity = .hour) async throws -> [CountTweetModel] {
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
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedNilValueQueries: [String: String?] = queries.filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: removedNilValueQueries)
        
    let countTweetResponseModel = try JSONDecoder().decode(CountTweetResponseModel.self, from: data)
    
    return countTweetResponseModel.countTweetModels
  }
}

public enum DateGranularity: String {
  case day
  case hour
  case minute
}
