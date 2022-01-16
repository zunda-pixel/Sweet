//
//  Mutes.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  public func fetchMuting(by userID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/get-users-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/muting")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)

    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func muteUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/post-users-user_id-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/muting")!
    
    let httpMethod: HTTPMethod = .POST
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let muteResponseModel = try JSONDecoder().decode(MuteResponseModel.self, from: data)
    
    return muteResponseModel.muting
  }
  
  public func unMuteUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/delete-users-user_id-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/muting/\(toUserID)")!
    
    let httpMethod: HTTPMethod = .DELETE
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let muteResponseModel = try JSONDecoder().decode(MuteResponseModel.self, from: data)
    
    return muteResponseModel.muting
  }
}