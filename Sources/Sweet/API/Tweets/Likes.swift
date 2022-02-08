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
                                   userFields: [UserField] = [], mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-tweets-id-liking_users
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/liking_users")!

    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func fetchLikedTweet(by userID: String, maxResults: Int = 100, paginationToken: String? = nil,
                              tweetFields: [TweetField] = [], mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-users-id-liked_tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/liked_tweets")!
    
    let queries: [String: String?] = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  public func like(userID: String, tweetID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/post-users-id-likes
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/likes")!
    
    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    let likeResponseModel = try JSONDecoder().decode(LikeResponseModel.self, from: data)
    
    return likeResponseModel.liked
  }
  
  public func unLike(userID: String, tweetID: String) async throws -> Bool {
    ///https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/delete-users-id-likes-tweet_id
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/likes/\(tweetID)")!

    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
    
    let likeResponseModel = try JSONDecoder().decode(LikeResponseModel.self, from: data)
    
    return likeResponseModel.liked
  }
}
