//
//  ListFollows.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func unFollowList(userID: String, listID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/delete-users-id-followed-lists-list_id

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists/\(listID)")!

    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
            
    let unFollowResponseModel = try JSONDecoder().decode(UnFollowResponseModel.self, from: data)
    
    return unFollowResponseModel.following
  }

  public func followList(userID: String, listID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/post-users-id-followed-lists

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists")!
    
    let body = ["list_id": listID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    let unFollowResponseModel = try JSONDecoder().decode(UnFollowResponseModel.self, from: data)
    
    return unFollowResponseModel.following
  }

  public func fetchFollowedUsers(listID: String, maxResults: Int = 100, paginationToken: String? = nil, fields: [UserField] = []) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-lists-id-followers
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/followers")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      UserField.key: fields.map(\.rawValue).joined(separator: ",")
    ].filter { $0.value != nil }

    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
            
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }

  public func fetchFollowingLists(userID: String, maxResults: Int = 100, paginationToken: String? = nil, fields: [ListField] = []) async throws -> [ListModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-users-id-followed_lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      ListField.key: fields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    print(String(data: data, encoding: .utf8)!)
    
    let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
    
    return listsResponseModel.lists
  }
}
