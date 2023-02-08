//
//  ListMembers.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Add Member To List
  /// - Parameters:
  ///   - listID: List ID
  ///   - userID: User(Member) ID
  public func addListMember(
    to listID: String,
    userID: String
  ) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/post-lists-id-members

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!

    let body = ["user_id": userID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(MemberResponse.self, from: data) {
      if response.isMember {
        return
      } else {
        throw TwitterError.listMemberError
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Delete Member From List
  /// - Parameters:
  ///   - listID: List ID
  ///   - userID: User ID
  public func deleteListMember(
    listID: String,
    userID: String
  ) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/delete-lists-id-members-user_id

    let method: HTTPMethod = .delete

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members/\(userID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(MemberResponse.self, from: data) {
      if response.isMember {
        throw TwitterError.listMemberError
      } else {
        return
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Fetch  List that users added
  /// - Parameters:
  ///   - userID: Added User ID
  ///   - maxResults: Max List Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Lists
  public func addedLists(
    userID: String,
    maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> ListsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-users-id-list_memberships

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/list_memberships")!

    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      Expansion.key: allListExpansion.joined(separator: ","),
      ListField.key: listFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(ListsResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Fetch Members(Users) belonging to the List
  /// - Parameters:
  ///   - listID: List ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Members(Users)
  public func listMembers(
    listID: String,
    maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-lists-id-members

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/members")!

    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }
}
