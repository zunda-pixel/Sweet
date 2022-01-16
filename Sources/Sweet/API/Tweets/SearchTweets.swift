//
//  SearchTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  func searchRecentTweet(by query: String, maxResult: Int = 10) async throws -> [TweetModel] {
    // TODO 動作しない
    
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/recent")!
    
    let queries = [
      "query": query,
      "max_results": String(maxResult),
    ]
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = bearerHeaders // try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func searchTweet(by query: String, maxResult: Int = 10) async throws -> [TweetModel] {
    // TODO 動作しない
    
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/all")!
    
    let queries = [
      "query": query,
      "max_results": String(maxResult),
    ]
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}
