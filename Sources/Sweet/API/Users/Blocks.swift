//
//  Blocks.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchBlocking(by userID: String, maxResults: Int = 100, paginationToken: String? = nil,
                            userFields: [UserField] = [], tweetFields: [TweetField] = []) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/get-users-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/blocking")!
    
    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func blockUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/post-users-user_id-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking")!
    
    let headers = getBearerHeaders(type: .User)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    let blockResponseModel = try JSONDecoder().decode(BlockResponseModel.self, from: data)
    
    return blockResponseModel.blocking
  }
  
  public func unBlockUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/delete-users-user_id-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking/\(toUserID)")!
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
    
    let blockResponseModel = try JSONDecoder().decode(BlockResponseModel.self, from: data)
    
    return blockResponseModel.blocking
  }
}
