//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchStreamRule() async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
        
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
    
    let streamRuleResponseModel = try JSONDecoder().decode(StreamRuleResponseModel.self, from: data)
    
    return streamRuleResponseModel.streamRules
  }
  
  public func fetchStream(delegate: URLSessionDataDelegate) -> URLSessionDataTask {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/get-tweets-search-stream
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream")!
    
    let headers = getBearerHeaders(type: .App)
    
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
    
    let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    return session.dataTask(with: request)
  }
  
  public func createStreamRule(_ streamRuleModels: [StreamRuleModel]) async throws -> [StreamRuleModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let headers = getBearerHeaders(type: .App)
    
    let body = ["add": streamRuleModels]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    let streamRuleResponseModel = try JSONDecoder().decode(StreamRuleResponseModel.self, from: data)
    
    return streamRuleResponseModel.streamRules
  }
  
  public func deleteStreamRule(ids: [String]) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let headers = getBearerHeaders(type: .App)
    
    let body = ["delete": ["ids": ids]]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let _ = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
  }
  
  public func deleteStreamRule(values: [String]) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/filtered-stream/api-reference/post-tweets-search-stream-rules
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/search/stream/rules")!
    
    let headers = getBearerHeaders(type: .App)
    
    let body = ["delete": ["values": values]]
    
    let bodyData = try JSONEncoder().encode(body)
    
    let _ = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
  }
}
