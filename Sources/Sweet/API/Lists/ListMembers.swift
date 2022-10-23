//
//  ListMembers.swift
//
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Add Member To List
  /// - Parameters:
  ///   - listID: List ID
  ///   - userID: User(Member) ID
  public func addListMember(to listID: String, userID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/post-lists-id-members

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!

    let body = ["user_id": userID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .post(url: url, body: bodyData, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(MemberResponse.self, from: data) {
      if response.isMember {
        return
      } else {
        throw TwitterError.listError
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Delete Member From List
  /// - Parameters:
  ///   - listID: List ID
  ///   - userID: User ID
  public func deleteListMember(listID: String, userID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/delete-lists-id-members-user_id

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members/\(userID)")!

    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .delete(url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(MemberResponse.self, from: data) {
      if response.isMember {
        throw TwitterError.listError
      } else {
        return
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch  List that users added
  /// - Parameters:
  ///   - userID: Added User ID
  ///   - maxResults: Max List Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Lists
  public func fetchAddedLists(userID: String, maxResults: Int = 100, paginationToken: String? = nil)
    async throws -> ListsResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-users-id-list_memberships

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/list_memberships")!

    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      Expansion.key: [ListExpansion.ownerID].map(\.rawValue).joined(separator: ","),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: authorizeType)

    let request: URLRequest = .get(url: url, headers: headers, queries: queries)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(ListsResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch Members(Users) belonging to the List
  /// - Parameters:
  ///   - listID: List ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Members(Users)
  public func fetchListMembers(
    listID: String, maxResults: Int = 100, paginationToken: String? = nil
  ) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-lists-id-members

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!

    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: authorizeType)

    let request: URLRequest = .get(url: url, headers: headers, queries: queries)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
