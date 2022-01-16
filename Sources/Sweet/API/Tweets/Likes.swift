//
//  Likes.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation

extension Sweet {
  func fetchLikingTweetUser(by tweetID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-tweets-id-liking_users
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/liking_users")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  func fetchLikedTweet(by userID: String) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-users-id-liked_tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/liked_tweets")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
        
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func like(userID: String, tweetID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/post-users-id-likes
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/likes")!
    
    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)
    
    let httpMethod: HTTPMethod = .POST

    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let likeResponseModel = try JSONDecoder().decode(LikeResponseModel.self, from: data)
    
    return likeResponseModel.liked
  }
  
  func unLike(userID: String, tweetID: String) async throws -> Bool {
    ///https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/delete-users-id-likes-tweet_id
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/likes/\(tweetID)")!
    
    let httpMethod: HTTPMethod = .DELETE

    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let likeResponseModel = try JSONDecoder().decode(LikeResponseModel.self, from: data)
    
    return likeResponseModel.liked
  }
}