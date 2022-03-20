//
//  LookUpLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchList(listID: String, listFields: [ListField] = [], userFiedls: [UserField] = []) async throws -> ListModel {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-lists-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!
    
    let queries: [String: String?] = [
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFiedls.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(ListResponseModel.self, from: data) {
      return response.list
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func fetchOwnedLists(userID: String, maxResults: Int = 100, paginationToken: String? = nil,
                              listFields: [ListField] = [], userFields: [UserField] = []) async throws -> ([ListModel], MetaModel) {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-users-id-owned_lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/owned_lists")!
    
    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(ListsResponseModel.self, from: data) {
      return (response.lists, response.meta)
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}
