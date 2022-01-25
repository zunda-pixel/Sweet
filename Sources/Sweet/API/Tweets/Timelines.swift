//
//  Timelines.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  func fetchTimeLine(by userID: String) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/tweets")!
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func fetchMentions(by userID: String) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/mentions")!
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}
