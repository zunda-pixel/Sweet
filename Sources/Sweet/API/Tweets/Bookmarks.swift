//
//  Bookmarks.swift
//
//
//  Created by zunda on 2022/05/21.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchBookmarks(userID: String, paginationToken: String, maxResults: Int = 100) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/get-users-id-bookmarks

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/bookmarks")!

    let headers = getBearerHeaders(type: .User)

    let queries: [String: String?] = [
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)

    if let response = try? JSONDecoder().decode(TweetsResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  public func deleteBookmark(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/delete-users-id-bookmarks-tweet_id

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/boomarks/\(tweetID)")!

    let headers = getBearerHeaders(type: .User)

    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers)

    if let response = try? JSONDecoder().decode(BookmarkResponse.self, from: data) {
      if response.bookmarked {
        throw TwitterError.bookmarkError
      } else {
        return
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  public func addBookmark(userID: String, tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/bookmarks/api-reference/delete-users-id-bookmarks-tweet_id

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/bookmarks/")!

    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(type: .User)

    let (data, urlResponse) = try await HTTPClient.get(url: url, body: bodyData, headers: headers)

    if let response = try? JSONDecoder().decode(BookmarkResponse.self, from: data) {
      if response.bookmarked {
        return
      } else {
        throw TwitterError.bookmarkError
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
