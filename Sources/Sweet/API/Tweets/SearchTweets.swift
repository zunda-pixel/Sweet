//
//  SearchTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func searchRecentTweet(by query: String, fields: [TweetField] = [], maxResult: Int = 10) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
    // This endpoint is only available for Academic Research access.
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/recent")!
    
    let queries = [
      "query": query,
      TweetField.key: fields.map(\.rawValue).joined(separator: ","),
    ]
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
            
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  public func searchTweet(by query: String, fields: [TweetField] = [], maxResult: Int = 10) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/all")!
    
    let queries = [
      "query": query,
      TweetField.key: fields.map(\.rawValue).joined(separator: ","),
    ]
        
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}
