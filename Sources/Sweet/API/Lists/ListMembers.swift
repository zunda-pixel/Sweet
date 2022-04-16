//
//  ListMembers.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func addListMember(to listID: String, userID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/post-lists-id-members
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!
    
    let body = ["user_id": userID]
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(MemberResponse.self, from: data) {
      if response.isMember {
        return
      } else {
        throw TwitterError.listError
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func deleteListMember(from listID: String, userID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/delete-lists-id-members-user_id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members/\(userID)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.delete(url: url, headers: headers)
    
    if let response = try? JSONDecoder().decode(MemberResponse.self, from: data) {
      if response.isMember {
        throw TwitterError.listError
      } else {
        return
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func fetchAddedLists(userID: String, maxResults: Int = 100, paginationToken: String? = nil) async throws -> ListsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-users-id-list_memberships
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/list_memberships")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      Expansion.key: [ListExpansion.ownerID].map(\.rawValue).joined(separator: ","),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(ListsResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func fetchAddedUsersToList(listID: String, maxResults: Int = 100, paginationToken: String? = nil) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-lists-id-members
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
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
}
