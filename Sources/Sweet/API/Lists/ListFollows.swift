//
//  ListFollows.swift
//
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Unfollow List
  /// - Parameters:
  ///   - userID: UnFollowing by This User
  ///   - listID: UnFollowed List ID
  public func unFollowList(userID: String, listID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/delete-users-id-followed-lists-list_id

    let method: HTTPMethod = .delete

    let url: URL = .init(
      string: "https://api.twitter.com/2/users/\(userID)/followed_lists/\(listID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UnFollowResponse.self, from: data) {
      if response.following {
        throw TwitterError.followError
      } else {
        return
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Follow List
  /// - Parameters:
  ///   - userID: Following by This User
  ///   - listID: Following List ID
  public func followList(userID: String, listID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/post-users-id-followed-lists

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists")!

    let body = ["list_id": listID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UnFollowResponse.self, from: data) {
      if response.following {
        return
      } else {
        throw TwitterError.followError
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch Followers(Users) that is following List
  /// - Parameters:
  ///   - listID: List ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Followers(Users)
  public func listFollowers(
    listID: String, maxResults: Int = 100, paginationToken: String? = nil
  ) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-lists-id-followers

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/followers")!

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

    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch List that is followed by this user
  /// - Parameters:
  ///   - userID: Following User
  ///   - maxResults: Max List Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Lists
  public func listsFollowed(
    by userID: String, maxResults: Int = 100, paginationToken: String? = nil
  ) async throws -> ListsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-users-id-followed_lists

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followed_lists")!

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

    if let response = try? JSONDecoder().decode(ListsResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
