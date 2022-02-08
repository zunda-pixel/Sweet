//
//  Timelines.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchTimeLine(by userID: String, maxResults: Int = 10,
                            startTime: Date? = nil, endTime: Date? = nil,
                            untilID: String? = nil, sinceID: String? = nil,
                            paginationToken: String? = nil,
                            tweetFields: [TweetField] = [], mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/tweets")!
    
    var queries: [String:  String?] = [
      "max_results": String(maxResults),
      "until_id": untilID,
      "since_id": sinceID,
      "pagination_token": paginationToken,
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedNilValueQueries: [String: String?] = queries.filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: removedNilValueQueries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
  
  public func fetchMentions(by userID: String, maxResults: Int = 10,
                            startTime: Date? = nil, endTime: Date? = nil,
                            untilID: String? = nil, sinceID: String? = nil,
                            paginationToken: String? = nil,
                            tweetFields: [TweetField] = [], mediaFields: [MediaField] = [], pollFields: [PollField] = []) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/mentions")!
    
    var queries: [String: String?] = [
      "max_results": String(maxResults),
      "until_id": untilID,
      "since_id": sinceID,
      "pagination_token": paginationToken,
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    
    if let startTime = startTime {
      queries["start_time"] = formatter.string(from: startTime)
    }
    
    if let endTime = endTime {
      queries["end_time"] = formatter.string(from: endTime)
    }
    
    let removedNilValueQueries: [String: String?] = queries.filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: removedNilValueQueries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}
