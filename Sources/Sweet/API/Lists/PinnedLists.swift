//
//  PinndedLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func pinList(userID: String, listID: String) async throws -> Bool {
		// https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/post-users-id-pinned-lists
    
		let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists")!
    
    let body = ["list_id": listID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
						
		let pinResponseModel = try JSONDecoder().decode(PinResponseModel.self, from: data)
		
		return pinResponseModel.pinned
	}

  public func unPinList(userID: String, listID: String) async throws -> Bool {
		// https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/delete-users-id-pinned-lists-list_id

		let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists/\(listID)")!
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
						
		let pinResponseModel = try JSONDecoder().decode(PinResponseModel.self, from: data)
		
		return pinResponseModel.pinned
	}

  public func fetchPinnedLists(userID: String, listFields: [ListField] = [], userFields: [UserField] = []) async throws -> [ListModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/get-users-id-pinned_lists

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists")!
    
    let queries = [
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
		let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
		
		return listsResponseModel.lists
  }
}
