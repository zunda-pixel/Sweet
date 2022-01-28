//
//  LookupTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func lookUpTweets(by ids: [String]) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!
    
    let queries = ["ids": ids.joined(separator: ",")]
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  public func lookUpTweet(by id: String) async throws -> TweetModel {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(id)")!
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
    
    let tweetResponseModel = try JSONDecoder().decode(TweetResponseModel.self, from: data)
    
    return tweetResponseModel.tweet
  }
}
