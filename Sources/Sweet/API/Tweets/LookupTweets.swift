//
//  LookupTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  func lookUpTweets(by ids: [String]) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!
    
    let queries = ["ids": ids.joined(separator: ",")]
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = bearerHeaders // try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func lookUpTweet(by id: String) async throws -> TweetModel {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(id)")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let tweetResponseModel = try JSONDecoder().decode(TweetResponseModel.self, from: data)
    
    return tweetResponseModel.tweet
  }
}
