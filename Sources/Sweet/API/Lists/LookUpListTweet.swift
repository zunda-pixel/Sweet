//
//  LookUpListTweets.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Tweets in List
  /// - Parameters:
  ///   - listID: List ID
  ///   - maxResults: Max Tweet Count
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  /// - Returns: Tweets
  public func listTweets(
    listID: String,
    maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-tweets/api-reference/get-lists-id-tweets

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/tweets")!

    let queries: [String: String?] = [
      Expansion.key: allTweetExpansion.joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
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
}
