//
//  LookUpLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Fetch List by List ID
  /// - Parameter listID: List ID
  /// - Returns: List
  public func fetchList(listID: String) async throws -> ListResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-lists-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!
    
    let queries: [String: String?] = [
      Expansion.key: [ListExpansion.ownerID].map(\.rawValue).joined(separator: ","),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: authorizeType)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(ListResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Fetch Lists that User Owned
  /// - Parameters:
  ///   - userID: User ID
  ///   - maxResults: Max List Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Lists
  public func fetchOwnedLists(userID: String, maxResults: Int = 100, paginationToken: String? = nil) async throws -> ListsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-users-id-owned_lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/owned_lists")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      Expansion.key: [ListExpansion.ownerID].map(\.rawValue).joined(separator: ","),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: authorizeType)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(ListsResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
