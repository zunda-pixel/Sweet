//
//  PinndedLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
	func pinList(userID: String, listID: String) async throws -> Bool {
		// https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/post-lists
		
		let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists")!
    
    let body = ["list_id": listID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
						
		let pinResponseModel = try JSONDecoder().decode(PinResponseModel.self, from: data)
		
		return pinResponseModel.pinned
	}

  func unPinList(userID: String, listID: String) async throws -> Bool {
		// https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/delete-users-id-pinned-lists-list_id

		let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists/\(listID)")!
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
						
		let pinResponseModel = try JSONDecoder().decode(PinResponseModel.self, from: data)
		
		return pinResponseModel.pinned
	}

  func fetchPinnedLists(userID: String) async throws -> [ListModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/get-users-id-pinned_lists

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists")!
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.get(url: url, headers: headers)
						
		let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
		
		return listsResponseModel.lists
  }
}
