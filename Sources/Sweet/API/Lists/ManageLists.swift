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

    let body = SendListModel(name: name, description: description, isPrivate: isPrivate)

    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
        
		let listResponseModel = try JSONDecoder().decode(ListResponseModel.self, from: data)
		
		return listResponseModel.list
	}

	func updateList(listID: String, name: String? = nil, description: String? = nil, isPrivate: Bool? = nil) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/put-lists-id

		let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!

    let body = SendListModel(name: name, description: description, isPrivate: isPrivate)
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.put(url: url, body: bodyData, headers: headers)
						
		let updateResponseModel = try JSONDecoder().decode(UpdateResponseModel.self, from: data)
		
		return updateResponseModel.updated
	}

  func deleteList(by listID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/delete-lists-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!

    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
						
		let deleteResponseModel = try JSONDecoder().decode(DeleteResponseModel.self, from: data)
		
		return deleteResponseModel.deleted
  }
}
