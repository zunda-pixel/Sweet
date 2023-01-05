//
//  ManageTweets.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Create New Tweet
  /// - Parameter postTweetModel: Post TweetModel
  /// - Returns: Created Tweet
  public func createTweet(_ postTweetModel: PostTweetModel) async throws -> TweetResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets

    let method: HTTPMethod = .post

    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let bodyData = try JSONEncoder().encode(postTweetModel)

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(TweetResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }

  /// Delete Tweet of TweetID
  /// - Parameter id: TweetID
  public func deleteTweet(of tweetID: String) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id

    let method: HTTPMethod = .delete

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)")!

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(DeleteResponse.self, from: data) {
      if response.deleted {
        return
      } else {
        throw TwitterError.deleteTweetError
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }
}
