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
    // This endpoint is only available for Academic Research access.
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/recent")!
    
    var queries = [
      "query": query,
      TweetField.key: fields.map(\.rawValue).joined(separator: ","),
      "max_results": String(maxResults),
    ]
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    if let untilID = untilID {
      queries["until_id"] = untilID
    }
    
    if let sinceID = sinceID {
      queries["since_id"] = sinceID
    }
    
    if let nextToken = nextToken {
      queries["next_token"] = nextToken
    }
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
            
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  public func searchTweet(by query: String, fields: [TweetField] = [], maxResults: Int = 10,
                          startTime: Date? = nil, endTime: Date? = nil,
                          untilID: String? = nil, sinceID: String? = nil,
                          nextToken: String? = nil) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/all")!
    
    var queries = [
      "query": query,
      TweetField.key: fields.map(\.rawValue).joined(separator: ","),
      "max_results": String(maxResults),
    ]
     
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    if let untilID = untilID {
      queries["until_id"] = untilID
    }
    
    if let sinceID = sinceID {
      queries["since_id"] = sinceID
    }
    
    if let nextToken = nextToken {
      queries["next_token"] = nextToken
    }
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}
