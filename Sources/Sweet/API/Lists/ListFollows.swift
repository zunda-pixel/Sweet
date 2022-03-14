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
    
    let (data, urlResponse) = try await HTTPClient.delete(url: url, headers: headers)
            
    if let response = try? JSONDecoder().decode(UnFollowResponseModel.self, from: data) {
      return response.following
    }
        
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
          throw TwitterError.invalidRequest(error: response)
        }
        
        throw TwitterError.unknwon(data: data, response: urlResponse)
  }

  public func followList(userID: String, listID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/post-users-id-followed-lists

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists")!
    
    let body = ["list_id": listID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(UnFollowResponseModel.self, from: data) {
      return response.following
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
          throw TwitterError.invalidRequest(error: response)
        }
        
        throw TwitterError.unknwon(data: data, response: urlResponse)
  }

  public func fetchFollowedUsers(listID: String, maxResults: Int = 100, paginationToken: String? = nil,
                                 userFields: [UserField] = [], tweetFields: [TweetField] = []) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-lists-id-followers
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/followers")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      UserField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil }

    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
            
    if let response = try? JSONDecoder().decode(UsersResponseModel.self, from: data) {
      return response.users
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }

  public func fetchFollowingLists(userID: String, maxResults: Int = 100, paginationToken: String? = nil,
                                  listFields: [ListField] = [], userFields: [UserField] = []) async throws -> [ListModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-users-id-followed_lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    if let response = try? JSONDecoder().decode(ListsResponseModel.self, from: data) {
      return response.lists
    }
        
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}
