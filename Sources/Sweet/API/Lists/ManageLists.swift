//
//  ManageLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Create List
  /// - Parameters:
  ///   - name: List Name
  ///   - description: List Description
  ///   - isPrivate: isPrivate
  /// - Returns: Created List
  public func createList(name: String, description: String? = nil, isPrivate: Bool = false) async throws -> ListModel {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/post-lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists")!
    
    let body = PostListModel(name: name, description: description, isPrivate: isPrivate)
    
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await session.post(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(ListResponse.self, from: data) {
      return response.list
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Update List Information
  /// - Parameters:
  ///   - listID: List ID to updated
  ///   - name: List Name
  ///   - description: List Description
  ///   - isPrivate: isPrivate
  public func updateList(listID: String, name: String? = nil, description: String? = nil, isPrivate: Bool? = false) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/put-lists-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!
    
    let body = PostListModel(name: name, description: description, isPrivate: isPrivate)
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await session.put(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(UpdateResponse.self, from: data) {
      if response.updated {
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

  /// Delete List of List ID
  /// - Parameter listID: List ID
  public func deleteList(listID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/delete-lists-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await session.delete(url: url, headers: headers)
    
    if let response = try? JSONDecoder().decode(DeleteResponse.self, from: data) {
      if response.deleted {
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
}
