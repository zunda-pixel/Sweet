//
//  Mutes.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Users that Muting
  /// - Parameters:
  ///   - userID: User ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Users
  public func mutingUsers(userID: String, maxResults: Int = 100, paginationToken: String? = nil)
    async throws -> UsersResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/get-users-muting

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/muting")!

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
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
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Mute User
  /// - Parameters:
  ///   - fromUserID: Muting User ID
  ///   - toUserID: Muted User ID
  public func muteUser(from fromUserID: String, to toUserID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/post-users-user_id-muting

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/muting")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(MuteResponse.self, from: data) {
      if response.muting {
        return
      } else {
        throw TwitterError.muteError
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Un Mute User
  /// - Parameters:
  ///   - fromUserID: Un Muting User ID
  ///   - toUserID: Un Muted User ID
  public func unMuteUser(from fromUserID: String, to toUserID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/delete-users-user_id-muting

    let method: HTTPMethod = .delete

    let url: URL = .init(
      string: "https://api.twitter.com/2/users/\(fromUserID)/muting/\(toUserID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(MuteResponse.self, from: data) {
      if response.muting {
        throw TwitterError.muteError
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
