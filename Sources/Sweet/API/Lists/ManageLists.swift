//
//  ManageLists.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Create List
  /// - Parameters:
  ///   - name: List Name
  ///   - description: List Description
  ///   - isPrivate: isPrivate
  /// - Returns: Created List
  public func createList(
    name: String,
    description: String? = nil,
    isPrivate: Bool = false
  ) async throws -> ListModel {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/post-lists

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/lists")!

    let body = PostListModel(name: name, description: description, isPrivate: isPrivate)

    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(ListResponse.self, from: data) {
      return response.list
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Update List Information
  /// - Parameters:
  ///   - listID: List ID to updated
  ///   - name: List Name
  ///   - description: List Description
  ///   - isPrivate: isPrivate
  public func updateList(
    listID: String,
    name: String? = nil,
    description: String? = nil,
    isPrivate: Bool? = false
  ) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/put-lists-id

    let method: HTTPMethod = .put

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!

    let body = PostListModel(name: name, description: description, isPrivate: isPrivate)
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(UpdateResponse.self, from: data) {
      if response.updated {
        return
      } else {
        throw TwitterError.updateListError
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Delete List of List ID
  /// - Parameter listID: List ID
  public func deleteList(listID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/delete-lists-id

    let method: HTTPMethod = .delete

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(DeleteResponse.self, from: data) {
      if response.deleted {
        return
      } else {
        throw TwitterError.deleteListError
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }
}
