//
//  ManageTweets.swift
//
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Create New Tweet
  /// - Parameter postTweetModel: Post TweetModel
  /// - Returns: Created Tweet
  public func createTweet(_ postTweetModel: PostTweetModel) async throws -> TweetResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets

    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!

    let headers = getBearerHeaders(type: .user)

    let bodyData = try JSONEncoder().encode(postTweetModel)

    let (data, urlResponse) = try await session.data(for: .post(url: url, body: bodyData, headers: headers))

    if let response = try? JSONDecoder().decode(TweetResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Delete Tweet of TweetID
  /// - Parameter id: TweetID
  public func deleteTweet(of tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)")!

    let headers = getBearerHeaders(type: .user)

    let (data, urlResponse) = try await session.data(for: .delete(url: url, headers: headers))

    if let response = try? JSONDecoder().decode(DeleteResponse.self, from: data) {
      if response.deleted {
        return
      } else {
        throw TwitterError.deleteError
      }
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
