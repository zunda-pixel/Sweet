//
//  Mutes.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchMuting(by userID: String, maxResults: Int = 100, paginationToken: String? = nil, fields: [UserField] = []) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/get-users-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/muting")!
  
    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: fields.map(\.rawValue).joined(separator: ",")
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func muteUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/post-users-user_id-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/muting")!
        
    let headers = getBearerHeaders(type: .User)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    let muteResponseModel = try JSONDecoder().decode(MuteResponseModel.self, from: data)
    
    return muteResponseModel.muting
  }
  
  public func unMuteUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/delete-users-user_id-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/muting/\(toUserID)")!
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
    
    let muteResponseModel = try JSONDecoder().decode(MuteResponseModel.self, from: data)
    
    return muteResponseModel.muting
  }
}
