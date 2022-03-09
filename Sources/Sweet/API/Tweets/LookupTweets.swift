//
//  LookupTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient


extension Sweet {
  public func lookUpTweets(by ids: [String], tweetFields: [TweetField] = [], userFields: [UserField] = [],
                           mediaFields: [MediaField] = [], pollFields: [PollField] = [], placeFields: [PlaceField] = []) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!
    
    let queries = [
      "ids": ids.joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  public func lookUpTweet(by id: String, tweetFields: [TweetField] = [], userFields: [UserField] = [], placeFields: [PlaceField] = [],
                          mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> TweetModel {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(id)")!
    
    let queries = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let tweetResponseModel = try JSONDecoder().decode(TweetResponseModel.self, from: data)
    
    return tweetResponseModel.tweet
  }
}
