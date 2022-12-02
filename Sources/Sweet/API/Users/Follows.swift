//
//  Follows.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Follow User
  /// - Parameters:
  ///   - fromUserID: Following User ID
  ///   - toUserID: Followed User ID
  /// - Returns: Success, Pending State(Awaiting Approval)
  public func follow(from fromUserID: String, to toUserID: String) async throws -> (Bool, Bool) {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/post-users-source_user_id-following

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/following")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(FollowResponseModel.self, from: data) {
      return (response.following, response.pendingFollow)
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Un Follow User
  /// - Parameters:
  ///   - fromUserID: Un Following User ID
  ///   - toUserID: Un Followed User ID
  public func unFollow(from fromUserID: String, to toUserID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/delete-users-source_id-following

    let method: HTTPMethod = .delete

    let url: URL = .init(
      string: "https://api.twitter.com/2/users/\(fromUserID)/following/\(toUserID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(UnFollowResponse.self, from: data) {
      if response.following {
        throw TwitterError.followError
      } else {
        return
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch User that user  following
  /// - Parameters:
  ///   - userID: Following User ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Users
  public func followingUsers(userID: String, maxResults: Int = 100, paginationToken: String? = nil)
    async throws -> UsersResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-following

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/following")!

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
      method: method,
      url: url,
      queries: removedEmptyQueries,
      headers: headers
    )

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch User Followed By
  /// - Parameters:
  ///   - userID: User ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Users
  public func followerUsers(userID: String, maxResults: Int = 100, paginationToken: String? = nil)
    async throws -> UsersResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-followers

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followers")!

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
      method: method,
      url: url,
      queries: removedEmptyQueries,
      headers: headers
    )

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
