//
//  ManageLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
	func createList(name: String, description: String? = nil, isPrivate: Bool? = nil) async throws -> ListModel {
		// https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/post-lists
		
		let url: URL = .init(string: "https://api.twitter.com/2/lists")!

		let httpMethod: HTTPMethod = .POST

    let body = SendListModel(name: name, description: description, isPrivate: isPrivate)

    let bodyData = try JSONEncoder().encode(body)

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
						
		let listResponseModel = try JSONDecoder().decode(ListResponseModel.self, from: data)
		
		return listResponseModel.list
	}

	func updateList(listID: String, name: String? = nil, description: String? = nil, isPrivate: Bool? = nil) async throws -> [ListModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/put-lists-id

		let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!


    let body = SendListModel(name: name, description: description, isPrivate: isPrivate)
    let bodyData = try JSONEncoder().encode(body)

		let httpMethod: HTTPMethod = .PUT

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
						
		let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
		
		return listsResponseModel.lists
	}

  func deleteList(by listID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/delete-lists-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!

    let httpMethod: HTTPMethod = .DELETE

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
						
		let deleteResponseModel = try JSONDecoder().decode(DeleteResponseModel.self, from: data)
		
		return deleteResponseModel.deleted
  }
}
