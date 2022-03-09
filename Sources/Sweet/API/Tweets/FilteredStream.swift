//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchStreamRule(ids: [String]? = nil) async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
        
    var quries: [String: String?] = [:]
    
    if let ids = ids {
      quries["ids"] = ids.joined(separator: ",")
    }
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
    
    let streamRuleResponseModel = try JSONDecoder().decode(StreamRuleResponseModel.self, from: data)
    
    return streamRuleResponseModel.streamRules
  }
  
  public func fetchStream(delegate: URLSessionDataDelegate, backfillMinutes: Int? = nil,
                          tweetFields: [TweetField] = [], mediaFields: [MediaField] = [],
                          pollFields: [PollField] = [], placeFields: [PlaceField] = [], userFields: [UserField] = []) -> URLSessionDataTask {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream")!
    
    var queries = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    if let backfillMinutes = backfillMinutes {
      queries["backfill_minutes"] =  String(backfillMinutes)
    }
    
    let headers = getBearerHeaders(type: .App)
    
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
    
    let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    return session.dataTask(with: request)
  }
  
  public func createStreamRule(_ streamRuleModels: [StreamRuleModel], dryRun: Bool = false) async throws -> StreamRuleModel {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let headers = getBearerHeaders(type: .App)
    
    let queries = [
      "dry_run": String(dryRun)
    ]
    
    let body = ["add": streamRuleModels]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers, queries: queries)
    
    let streamRuleResponseModel = try JSONDecoder().decode(StreamRuleResponseModel.self, from: data)
    
    return streamRuleResponseModel.streamRules.first!
  }
  
  public func deleteStreamRule(ids: [String], dryRun: Bool = false) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let queries = [
      "dry_run": String(dryRun)
    ]
    
    let headers = getBearerHeaders(type: .App)
    
    let body = ["delete": ["ids": ids]]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let _ = try await HTTPClient.post(url: url, body: bodyData, headers: headers, queries: queries)
  }
  
  public func deleteStreamRule(values: [String], dryRun: Bool = false) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let queries = [
      "dry_run": String(dryRun)
    ]
    
    let headers = getBearerHeaders(type: .App)
    
    let body = ["delete": ["values": values]]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let _ = try await HTTPClient.post(url: url, body: bodyData, headers: headers, queries: queries)
  }
}
