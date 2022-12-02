//
//  Retweets.swift
//

import Foundation
import HTTPClient
import HTTPMethod

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

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/retweeted_by")!

    let queries: [String: String?] = [
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
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

  /// Retweet Tweet
  /// - Parameters:
  ///   - userID: User ID
  ///   - tweetID: Tweet ID
  public func retweet(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/post-users-id-retweets

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets")!

    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(RetweetResponse.self, from: data) {
      if response.retweeted {
        return
      } else {
        throw TwitterError.retweetError
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Delete Retweet Tweet
  /// - Parameters:
  ///   - userID: User ID
  ///   - tweetID: Tweet ID
  public func deleteRetweet(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/delete-users-id-retweets-tweet_id

    let method: HTTPMethod = .delete

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets/\(tweetID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(RetweetResponse.self, from: data) {
      if response.retweeted {
        throw TwitterError.retweetError
      } else {
        return
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
