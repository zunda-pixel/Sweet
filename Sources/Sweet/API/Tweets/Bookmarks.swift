//
//  Bookmarks.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Tweets in Bookmarks
  /// - Parameters:
  ///   - userID: User ID
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  ///   - maxResults: Max Bookmark Count
  /// - Returns: Tweets
  public func bookmarks(userID: String, paginationToken: String? = nil, maxResults: Int = 100)
    async throws -> TweetsResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/get-users-id-bookmarks

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/bookmarks")!

    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

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

  /// Delete Tweets in Bookmark
  /// - Parameters:
  ///   - userID: User ID that has Bookmark
  ///   - tweetID: Tweet ID
  public func deleteBookmark(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/delete-users-id-bookmarks-tweet_id

    let method: HTTPMethod = .delete

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/bookmarks/\(tweetID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(BookmarkResponse.self, from: data) {
      if response.bookmarked {
        throw TwitterError.bookmarkError
      } else {
        return
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Add Tweet to Bookmarks
  /// - Parameters:
  ///   - userID: User ID that has Bookmark
  ///   - tweetID: Tweet ID
  public func addBookmark(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/delete-users-id-bookmarks-tweet_id

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/bookmarks")!

    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(BookmarkResponse.self, from: data) {
      if response.bookmarked {
        return
      } else {
        throw TwitterError.bookmarkError
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }
}
