//
//  LookUpLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
	func fetchList(listID: String) async throws -> ListModel {
		// https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-lists-id

		let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!

		let httpMethod: HTTPMethod = .GET

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
						
		let listResponseModel = try JSONDecoder().decode(ListResponseModel.self, from: data)
		
		return listResponseModel.list
	}

	func fetchOwnedLists(userID: String) async throws -> [ListModel] {
		// https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-users-id-owned_lists

		let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/owned_lists")!

		let httpMethod: HTTPMethod = .GET

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
						
		let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
		
		return listsResponseModel.lists
	}
}