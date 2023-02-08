//
//  Likes.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Users that liking Tweet
  /// - Parameters:
  ///   - tweetID: Tweet ID
  ///   - maxResults: Max User Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Users
  public func likingTweetUsers(
    tweetID: String,
    maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-tweets-id-liking_users

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/liking_users")!

    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
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

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Fetch Tweets that Liked by User
  /// - Parameters:
  ///   - userID: User ID
  ///   - maxResults: Max Tweet Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Tweets
  public func likedTweet(
    userID: String,
    maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-users-id-liked_tweets

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/liked_tweets")!

    let queries: [String: String?] = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
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

    if let response = try? decoder.decode(TweetsResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Like Tweet
  /// - Parameters:
  ///   - userID: User ID
  ///   - tweetID: Tweet ID
  public func like(
    userID: String,
    tweetID: String
  ) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/post-users-id-likes

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/likes")!

    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(LikeResponse.self, from: data) {
      if response.liked {
        return
      } else {
        throw TwitterError.likeTweetError
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Un Like Tweet
  /// - Parameters:
  ///   - userID: User ID
  ///   - tweetID: Tweet ID
  public func unLike(
    userID: String,
    tweetID: String
  ) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/delete-users-id-likes-tweet_id

    let method: HTTPMethod = .delete

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/likes/\(tweetID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(LikeResponse.self, from: data) {
      if response.liked {
        throw TwitterError.likeTweetError
      } else {
        return
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }
}
