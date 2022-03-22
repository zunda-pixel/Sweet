//
//  Retweets.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchRetweetUsers(by tweetID: String, maxResults: Int = 100, paginationToken: String? = nil,
                                userFields: [UserField] = [], mediaFields: [MediaField] = [], placeFields: [PlaceField] = [],
                                pollFields: [PollField] = [], tweetFields: [TweetField] = []) async throws -> ([UserModel], MetaModel) {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/get-tweets-id-retweeted_by
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/retweeted_by")!
    
    let queries: [String: String?] = [
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return (response.users, response.meta!)
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func retweet(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/post-users-id-retweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets")!
    
    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    if let response  = try? JSONDecoder().decode(RetweetResponse.self, from: data) {
      if response.retweeted {
        return
      } else {
        throw TwitterError.retweetError
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func deleteRetweet(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/delete-users-id-retweets-tweet_id
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets/\(tweetID)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.delete(url: url, headers: headers)
    
    if let response  = try? JSONDecoder().decode(RetweetResponse.self, from: data) {
      if response.retweeted {
        throw TwitterError.retweetError
      } else {
        return
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}
