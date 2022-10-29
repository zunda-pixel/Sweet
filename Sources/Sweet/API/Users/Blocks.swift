//
//  Blocks.swift
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
  /// Fetch User that Blocking
  /// - Parameters:
  ///   - userID: Blocking User ID
  ///   - maxResults: Max Space Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Users
  public func blockingUsers(userID: String, maxResults: Int = 100, paginationToken: String? = nil)
    async throws -> UsersResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/get-users-blocking

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/blocking")!

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && !$0.value!.isEmpty }

    let headers = getBearerHeaders(type: .user)

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

  /// Block User
  /// - Parameters:
  ///   - fromUserID: Blocking User ID
  ///   - toUserID: Blocked User iD
  public func blockUser(from fromUserID: String, to toUserID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/post-users-user_id-blocking

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking")!

    let headers = getBearerHeaders(type: .user)

    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)

    let request: URLRequest = .post(url: url, body: bodyData, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(BlockResponse.self, from: data) {
      if response.blocking {
        return
      } else {
        throw TwitterError.blockError
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Un Block User
  /// - Parameters:
  ///   - fromUserID: Blocking User ID
  ///   - toUserID: Blocked User ID
  public func unBlockUser(from fromUserID: String, to toUserID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/delete-users-user_id-blocking

    let url: URL = .init(
      string: "https://api.twitter.com/2/users/\(fromUserID)/blocking/\(toUserID)")!

    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .delete(url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(BlockResponse.self, from: data) {
      if response.blocking {
        throw TwitterError.blockError
      } else {
        return
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
