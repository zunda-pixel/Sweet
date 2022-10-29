//
//  Retweets.swift
//
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Users that Retweet Tweet
  /// - Parameters:
  ///   - tweetID: Retweet Tweet ID
  ///   - maxResults: Max Tweet Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Users
  public func retweetUsers(
    tweetID: String, maxResults: Int = 100, paginationToken: String? = nil
  ) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/get-tweets-id-retweeted_by

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/retweeted_by")!

    let queries: [String: String?] = [
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
    ].filter { $0.value != nil && !$0.value!.isEmpty }

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

  /// Retweet Tweet
  /// - Parameters:
  ///   - userID: User ID
  ///   - tweetID: Tweet ID
  public func retweet(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/post-users-id-retweets

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets")!

    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .post(url: url, body: bodyData, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(RetweetResponse.self, from: data) {
      if response.retweeted {
        return
      } else {
        throw TwitterError.retweetError
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Delete Retweet Tweet
  /// - Parameters:
  ///   - userID: User ID
  ///   - tweetID: Tweet ID
  public func deleteRetweet(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/delete-users-id-retweets-tweet_id

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets/\(tweetID)")!

    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .delete(url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(RetweetResponse.self, from: data) {
      if response.retweeted {
        throw TwitterError.retweetError
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
