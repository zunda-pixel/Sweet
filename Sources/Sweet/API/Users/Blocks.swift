//
//  Blocks.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchBlocking(by userID: String, maxResults: Int = 100, paginationToken: String? = nil) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/get-users-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/blocking")!
    
    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func blockUser(from fromUserID: String, to toUserID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/post-users-user_id-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking")!
    
    let headers = getBearerHeaders(type: .User)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, urlResponse) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(BlockResponse.self, from: data) {
      if response.blocking {
        return
      } else {
        throw TwitterError.blockError
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func unBlockUser(from fromUserID: String, to toUserID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/delete-users-user_id-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking/\(toUserID)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.delete(url: url, headers: headers)
    
    if let response = try? JSONDecoder().decode(BlockResponse.self, from: data) {
      if response.blocking {
        throw TwitterError.blockError
      } else {
        return
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
