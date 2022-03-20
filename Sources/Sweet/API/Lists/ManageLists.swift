//
//  ManageLists.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func createList(name: String, description: String? = nil, isPrivate: Bool? = nil) async throws -> ListModel {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/post-lists
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists")!
    
    let body = SendListModel(name: name, description: description, isPrivate: isPrivate)
    
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(ListResponseModel.self, from: data) {
      return response.list
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
    
  }
  
  public func updateList(listID: String, name: String? = nil, description: String? = nil, isPrivate: Bool? = false) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/put-lists-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!
    
    let body = SendListModel(name: name, description: description, isPrivate: isPrivate)
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.put(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(UpdateResponseModel.self, from: data) {
      if !response.updated {
        return
      } else {
        throw TwitterError.listError
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func deleteList(by listID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/delete-lists-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.delete(url: url, headers: headers)
    
    if let response = try? JSONDecoder().decode(DeleteResponseModel.self, from: data) {
      if response.deleted {
        return
      } else {
        throw TwitterError.listError
      }
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}
