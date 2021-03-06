//
//  PinnedLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Pin List from User
  /// - Parameters:
  ///   - userID: Pinned From This User
  ///   - listID: List ID
  public func pinList(userID: String, listID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/post-users-id-pinned-lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists")!
    
    let body = ["list_id": listID]
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await session.post(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(PinResponse.self, from: data) {
      if response.pinned {
        return
      } else {
        throw TwitterError.listError
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// UnPin List from User
  /// - Parameters:
  ///   - userID: UnPinned From This User
  ///   - listID: UnPinned List ID
  public func unPinList(userID: String, listID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/delete-users-id-pinned-lists-list_id
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists/\(listID)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await session.delete(url: url, headers: headers)
    
    if let response = try? JSONDecoder().decode(PinResponse.self, from: data) {
      if response.pinned {
        throw TwitterError.listError
      } else {
        return
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Fetch Lists that Pinned by User
  /// - Parameter userID: Pinned By User
  /// - Returns: Lists
  public func fetchListsPinned(by userID: String) async throws -> ListsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/pinned-lists/api-reference/get-users-id-pinned_lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/pinned_lists")!
    
    let queries: [String: String?] = [
      Expansion.key: [ListExpansion.ownerID].map(\.rawValue).joined(separator: ","),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
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
