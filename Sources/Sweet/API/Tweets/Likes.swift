//
//  Likes.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchLikingTweetUser(by tweetID: String, maxResults: Int = 100, paginationToken: String? = nil,
                                   userFields: [UserField] = [], mediaFields: [MediaField] = [], pollFields: [PollField] = [],
                                   placeFields: [PlaceField] = [], tweetFields: [TweetField] = []) async throws -> ([UserModel], MetaModel) {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-tweets-id-liking_users
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/liking_users")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(UsersResponseModel.self, from: data) {
      return (response.users, response.meta!)
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func fetchLikedTweet(by userID: String, maxResults: Int = 100, paginationToken: String? = nil,
                              tweetFields: [TweetField] = [], userFields: [UserField] = [], placeFields: [PlaceField] = [],
                              mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> ([TweetModel], MetaModel) {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-users-id-liked_tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/liked_tweets")!
    
    let queries: [String: String?] = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(TweetsResponseModel.self, from: data) {
      return (response.tweets, response.meta)
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func like(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/post-users-id-likes
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/likes")!
    
    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(LikeResponseModel.self, from: data) {
      if !response.liked {
        throw TwitterError.likeError
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func unLike(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/delete-users-id-likes-tweet_id
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/likes/\(tweetID)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.delete(url: url, headers: headers)
    
    if let response = try? JSONDecoder().decode(LikeResponseModel.self, from: data) {
      if response.liked {
        throw TwitterError.likeError
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}
