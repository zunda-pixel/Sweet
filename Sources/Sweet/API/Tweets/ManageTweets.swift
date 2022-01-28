//
//  ManageTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func createTweet(text: String) async throws -> TweetModel {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!
        
    let headers = getBearerHeaders(type: .User)
    
    let body = ["text": text]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    let tweetResponseModel = try JSONDecoder().decode(TweetResponseModel.self, from: data)
    
    return tweetResponseModel.tweet
  }
  
  public func deleteTweet(by id: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(id)")!
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
    
    let deleteResponseModel = try JSONDecoder().decode(DeleteResponseModel.self, from: data)
    
    return deleteResponseModel.deleted
  }
}
