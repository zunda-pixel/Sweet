//
//  LookUpLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchList(listID: String, fields: [ListField] = []) async throws -> ListModel {
		// https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-lists-id

		let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!

    let queries: [String: String?] = [
      ListField.key: fields.map(\.rawValue).joined(separator: ",")
    ]
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
						
		let listResponseModel = try JSONDecoder().decode(ListResponseModel.self, from: data)
		
		return listResponseModel.list
	}

  public func fetchOwnedLists(userID: String, maxResults: Int = 100, paginationToken: String? = nil, fields: [ListField] = []) async throws -> [ListModel] {
		// https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-users-id-owned_lists

		let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/owned_lists")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      ListField.key: fields.map(\.rawValue).joined(separator: ",")
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
						
		let listsResponseModel = try JSONDecoder().decode(ListsResponseModel.self, from: data)
		
		return listsResponseModel.lists
	}
}
