//
//  TweetCounts.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  func fetchRecentCountTweet(by query: String) async throws -> [CountTweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-recent
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/recent")!
    
    let queries = ["query": query]
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let countTweetResponseModel = try JSONDecoder().decode(CountTweetResponseModel.self, from: data)
    
    return countTweetResponseModel.countTweetModels
  }
  
  func fetchCountTweet(by query: String) async throws -> [CountTweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-all
    // This endpoint is only available for Academic Research access.
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/all")!
    
    let queries = ["query": query]
        
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let countTweetResponseModel = try JSONDecoder().decode(CountTweetResponseModel.self, from: data)
    
    return countTweetResponseModel.countTweetModels
  }
}
