//
//  ManageTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  func createTweet(text: String) async throws -> TweetModel {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!
    
    let httpMethod: HTTPMethod = .POST
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let body = ["text": text]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let tweetResponseModel = try JSONDecoder().decode(TweetResponseModel.self, from: data)
    
    return tweetResponseModel.tweet
  }
  
  func deleteTweet(by id: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(id)")!
    
    let httpMethod: HTTPMethod = .DELETE
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let deleteTweetResponseModel = try JSONDecoder().decode(DeleteTweetResponseModel.self, from: data)
    
    return deleteTweetResponseModel.deleted
  }
}
