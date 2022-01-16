//
//  Blocks.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  public func fetchBlocking(by userID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/get-users-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/blocking")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
        
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func blockUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/post-users-user_id-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking")!
    
    let httpMethod: HTTPMethod = .POST
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let blockResponseModel = try JSONDecoder().decode(BlockResponseModel.self, from: data)
    
    return blockResponseModel.blocking
  }
  
  public func unBlockUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/delete-users-user_id-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking/\(toUserID)")!
    
    let httpMethod: HTTPMethod = .DELETE
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)

    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let blockResponseModel = try JSONDecoder().decode(BlockResponseModel.self, from: data)
    
    return blockResponseModel.blocking
  }
}
