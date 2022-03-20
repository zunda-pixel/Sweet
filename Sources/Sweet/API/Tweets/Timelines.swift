//
//  Timelines.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

public enum TweetExclude: String {
  case retweets
  case replies
}

extension Sweet {
  public func fetchTimeLine(by userID: String, maxResults: Int = 10,
                            startTime: Date? = nil, endTime: Date? = nil,
                            untilID: String? = nil, sinceID: String? = nil,
                            paginationToken: String? = nil, exclude: TweetExclude? = nil,
                            tweetFields: [TweetField] = [], userFields: [UserField] = [], placeFields: [PlaceField] = [],
                            mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> ([TweetModel], MetaModel) {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/tweets")!
    
    var queries: [String:  String?] = [
      "max_results": String(maxResults),
      "until_id": untilID,
      "since_id": sinceID,
      "pagination_token": paginationToken,
      "exclude": exclude?.rawValue,
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let formatter = TwitterDateFormatter()
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedEmptyQueries: [String: String?] = queries.filter { $0.value != nil || $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: removedEmptyQueries)
    
    if let response = try? JSONDecoder().decode(TweetsResponseModel.self, from: data) {
      return (response.tweets, response.meta)
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func fetchMentions(by userID: String, maxResults: Int = 10,
                            startTime: Date? = nil, endTime: Date? = nil,
                            untilID: String? = nil, sinceID: String? = nil, paginationToken: String? = nil,
                            tweetFields: [TweetField] = [], userFields: [UserField] = [], placeFields: [PlaceField] = [],
                            mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> ([TweetModel], MetaModel) {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/mentions")!
    
    var queries: [String: String?] = [
      "max_results": String(maxResults),
      "until_id": untilID,
      "since_id": sinceID,
      "pagination_token": paginationToken,
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let formatter = TwitterDateFormatter()
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedEmptyQueries: [String: String?] = queries.filter { $0.value != nil || $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: removedEmptyQueries)
    
    if let response = try? JSONDecoder().decode(TweetsResponseModel.self, from: data) {
      return (response.tweets, response.meta)
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}
