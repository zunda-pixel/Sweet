//
//  Follows.swift
//
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Follow User
  /// - Parameters:
  ///   - fromUserID: Following User ID
  ///   - toUserID: Followed User ID
  /// - Returns: Success, Pending State(Awaiting Approval)
  public func follow(from fromUserID: String, to toUserID: String) async throws -> (Bool, Bool) {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/post-users-source_user_id-following

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/following")!

    let headers = getBearerHeaders(type: .user)

    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)

    let request: URLRequest = .post(url: url, body: bodyData, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(FollowResponseModel.self, from: data) {
      return (response.following, response.pendingFollow)
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Un Follow User
  /// - Parameters:
  ///   - fromUserID: Un Following User ID
  ///   - toUserID: Un Followed User ID
  public func unFollow(from fromUserID: String, to toUserID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/delete-users-source_id-following

    let url: URL = .init(
      string: "https://api.twitter.com/2/users/\(fromUserID)/following/\(toUserID)")!

    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .delete(url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UnFollowResponse.self, from: data) {
      if response.following {
        throw TwitterError.followError
      } else {
        return
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch User that user  following
  /// - Parameters:
  ///   - userID: Following User ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Users
  public func fetchFollowing(userID: String, maxResults: Int = 100, paginationToken: String? = nil)
    async throws -> UsersResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-following

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/following")!

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
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

  /// Fetch User Followed By
  /// - Parameters:
  ///   - userID: User ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Users
  public func fetchFollower(userID: String, maxResults: Int = 100, paginationToken: String? = nil)
    async throws -> UsersResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-followers

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followers")!

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
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
