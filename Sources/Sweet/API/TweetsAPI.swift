//
//  TweetsAPI.swift
//  
//
//  Created by zunda on 2022/01/15.
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
  
  func fetchTimeLine(by userID: String) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/tweets")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func fetchMentions(by userID: String) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/mentions")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func searchRecentTweet(by query: String, maxResult: Int = 10) async throws -> [TweetModel] {
    // TODO動作しない
    
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/recent")!
    
    let queries = [
      "query": query,
      "max_results": String(maxResult),
    ]
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = bearerHeaders // try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func searchTweet(by query: String, maxResult: Int = 10) async throws -> [TweetModel] {
    // TODO動作しない
    
    // https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-all
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/all")!
    
    let queries = [
      "query": query,
      "max_results": String(maxResult),
    ]
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func fetchRecentCountTweet(by query: String) async throws -> [CountTweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-recent
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/recent")!
    
    let queries = ["query": query]
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let countTweetResponseModel = try JSONDecoder().decode(CountTweetResponseModel.self, from: data)
    
    return countTweetResponseModel.countTweetModels
  }
  
  func fetchCountTweet(by query: String) async throws -> [CountTweetModel] {
    // 動作しない
    
    // https://developer.twitter.com/en/docs/twitter-api/tweets/counts/api-reference/get-tweets-counts-all
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/counts/all")!
    
    let queries = ["query": query]
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers, queries: queries)
    
    let countTweetResponseModel = try JSONDecoder().decode(CountTweetResponseModel.self, from: data)
    
    return countTweetResponseModel.countTweetModels
  }
  
  func fetchStreamRule() async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let streamRuleResponseModel = try JSONDecoder().decode(StreamRuleResponseModel.self, from: data)
    
    return streamRuleResponseModel.streamRules
  }
  
  func fetchStream() async throws -> [StreamRuleModel] {
    // TODO 時間がかかりすぎてしまいUnit Testができていない
    
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream")!
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
        
    let streamRuleResponseModel = try JSONDecoder().decode(StreamRuleResponseModel.self, from: data)
    
    return streamRuleResponseModel.streamRules
  }
  
  func createStreamRule(_ streamRuleModels: [StreamRuleModel]) async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let headers = bearerHeaders
    
    let body = ["add": streamRuleModels]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    let streamRuleResponseModel = try JSONDecoder().decode(StreamRuleResponseModel.self, from: data)
    
    return streamRuleResponseModel.streamRules
  }
  
  func deleteStreamRule(ids: [String]) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let headers = bearerHeaders
    
    let body = ["delete": ["ids": ids]]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let _ = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
  }
  
  func deleteStreamRule(values: [String]) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let headers = bearerHeaders
    
    let body = ["delete": ["values": values]]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let _ = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
  }
  
  func fetchStreamVolume() async throws -> [TweetModel] {
    // TODO 時間がかかりすぎてしまいUnit Testができていない
    
    // https://developer.twitter.com/en/docs/twitter-api/tweets/volume-streams/api-reference/get-tweets-sample-stream
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/sample/stream")!
    
    let headers = bearerHeaders
            
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
        
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  func fetchRetweetUsers(by tweetID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/get-tweets-id-retweeted_by
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/retweeted_by")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
            
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  func retweet(userID: String, tweetID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/post-users-id-retweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets")!
    
    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)
    
    let httpMethod: HTTPMethod = .POST
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let retweetResponseModel  = try JSONDecoder().decode(RetweetResponseModel.self, from: data)
    
    return retweetResponseModel.retweeted
  }
  
  func deleteRetweet(userID: String, tweetID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/delete-users-id-retweets-tweet_id
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets/\(tweetID)")!
    
    let httpMethod: HTTPMethod = .DELETE
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let retweetResponseModel  = try JSONDecoder().decode(RetweetResponseModel.self, from: data)
    
    return retweetResponseModel.retweeted
  }
  
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
