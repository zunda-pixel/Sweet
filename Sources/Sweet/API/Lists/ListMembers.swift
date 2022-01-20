//
//  ListMembers.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  func addListMember(to listID: String, userID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/post-lists-id-members

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!

    let httpMethod: HTTPMethod = .POST

    let body = ["user_id": userID]
    let bodyData = try JSONEncoder().encode(body)

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
        
    
		let memberResponseModel = try JSONDecoder().decode(MemberResponseModel.self, from: data)
		
		return memberResponseModel.isMember
  }

  func deleteListMember(from listID: String, userID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/delete-lists-id-members-user_id

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members/\(userID)")!

    let httpMethod: HTTPMethod = .DELETE

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
						
		let memberResponseModel = try JSONDecoder().decode(MemberResponseModel.self, from: data)
		
		return memberResponseModel.isMember
  }

  func fetchAddedLists(userID: String) async throws -> [ListModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-users-id-list_memberships

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/list_memberships")!

    let httpMethod: HTTPMethod = .GET

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)

    let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
		
		return listsResponseModel.lists
  }

  func fetchAddedUsersToList(listID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-lists-id-members

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!

    let httpMethod: HTTPMethod = .GET

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
						
		let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
		
		return usersResponseModel.users
  }
}
