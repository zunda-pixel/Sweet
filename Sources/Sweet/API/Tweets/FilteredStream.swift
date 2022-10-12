//
//  FilteredStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Stream Rule with ids
  /// - Parameter ids: Stream Rule IDs
  /// - Returns: Stream Rules
  public func fetchStreamRule(ids: [String]? = nil) async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let queries: [String: String?] = [
      "ids": ids?.joined(separator: ",")
    ]
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(StreamRuleResponse.self, from: data) {
      return response.streamRules
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  /// Fetch Stream
  /// - Parameters:
  ///   - delegate: URLSessionDataDelegate for Stream
  ///   - backfillMinutes: Recovering missed data after a disconnection
  /// - Returns: URLSessionDataTask
  public func fetchStream(delegate: URLSessionDataDelegate, backfillMinutes: Int? = nil) -> URLSessionDataTask {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream")!
    
    @DictionaryBuilder<String, String?>
    var queries: [String: String?] {
      [
        TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
        MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
        UserField.key: userFields.map(\.rawValue).joined(separator: ","),
        PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
        PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
        Expansion.key: allTweetExpansion.joined(separator: ","),
      ]
      
      if let backfillMinutes {
        ["backfill_minutes": String(backfillMinutes)]
      }
    }
    
    let filteredQueries = queries.filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .App)
    
    var components: URLComponents = .init(url: url, resolvingAgainstBaseURL: true)!
    components.queryItems = filteredQueries.map { .init(name: $0, value: $1)}
    
    var request = URLRequest(url: components.url!)
    request.allHTTPHeaderFields = headers
    
    let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    return session.dataTask(with: request)
  }
  
  /// Create Stream Rule
  /// - Parameters:
  ///   - streamRuleModels: Stream Rule Models
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  /// - Returns: StreamRuleModel
  public func createStreamRule(_ streamRuleModels: [StreamRuleModel], dryRun: Bool = false) async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let headers = getBearerHeaders(type: .App)
    
    let queries: [String: String?] = [
      "dry_run": String(dryRun)
    ].filter { $0.value != nil && $0.value != ""}
    
    let body = ["add": streamRuleModels]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, urlResponse) = try await session.post(url: url, body: bodyData, headers: headers, queries: queries)
    
    let decoder = JSONDecoder()
    
    if let response = try? decoder.decode(CreateStreamRuleResponse.self, from: data) {
      return response.streamRules
    }
    
    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  /// Delete Stream Rules with IDs
  /// - Parameters:
  ///   - ids: Stream Rules ID
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  public func deleteStreamRule(ids: [String], dryRun: Bool = false) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let queries: [String: String?] = [
      "dry_run": String(dryRun)
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .App)
    
    let body = ["delete": ["ids": ids]]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let _ = try await session.post(url: url, body: bodyData, headers: headers, queries: queries)
  }
  
  /// Delete Stream Rules With Value
  /// - Parameters:
  ///   - values: Values
  ///   - dryRun: Set to true to test a the syntax of your rule without submitting it.
  ///   useful if you want to check the syntax of a rule before removing one or more of your existing rules.
  public func deleteStreamRule(values: [String], dryRun: Bool = false) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let queries: [String: String?] = [
      "dry_run": String(dryRun)
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .App)
    
    let body = ["delete": ["values": values]]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let _ = try await session.post(url: url, body: bodyData, headers: headers, queries: queries)
  }
}
