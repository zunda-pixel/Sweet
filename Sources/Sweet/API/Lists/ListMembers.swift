//
//  ListMembers.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func addListMember(to listID: String, userID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/post-lists-id-members

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!

    let body = ["user_id": userID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
        
		let memberResponseModel = try JSONDecoder().decode(MemberResponseModel.self, from: data)
		
		return memberResponseModel.isMember
  }

  public func deleteListMember(from listID: String, userID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/delete-lists-id-members-user_id

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members/\(userID)")!

    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
						
		let memberResponseModel = try JSONDecoder().decode(MemberResponseModel.self, from: data)
		
		return memberResponseModel.isMember
  }

  public func fetchAddedLists(userID: String, maxResults: Int = 100, paginationToken: String? = nil,
                              listFields: [ListField] = [], userFields: [UserField] = []) async throws -> [ListModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-users-id-list_memberships

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/list_memberships")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
		
		return listsResponseModel.lists
  }

  public func fetchAddedUsersToList(listID: String, maxResults: Int = 100, paginationToken: String? = nil,
                                    userFields: [UserField] = [], tweetFields: [TweetField] = []) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-lists-id-members

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
						
		let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
		
		return usersResponseModel.users
  }
}
