//
//  ListFollows.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  func unFollowList(userID: String, listID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/delete-users-id-followed-lists-list_id

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists/\(listID)")!

    let httpMethod: HTTPMethod = .DELETE

    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
            
    let unFollowResponseModel = try JSONDecoder().decode(UnFollowResponseModel.self, from: data)
    
    return unFollowResponseModel.following
  }

  func followList(userID: String, listID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/post-users-id-followed-lists

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists")!
    
    let body = ["list_id": listID]
    let bodyData = try JSONEncoder().encode(body)

    let httpMethod: HTTPMethod = .POST

    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
            
    let unFollowResponseModel = try JSONDecoder().decode(UnFollowResponseModel.self, from: data)
    
    return unFollowResponseModel.following
  }

  func fetchFollowedUsers(listID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-lists-id-followers
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/followers")!

    let httpMethod: HTTPMethod = .GET

    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
            
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }

  func fetchFollowingLists(listID: String) async throws -> [ListModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-users-id-followed_lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/followers")!

    let httpMethod: HTTPMethod = .GET

    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
            
    let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
    
    return listsResponseModel.lists
  }
}