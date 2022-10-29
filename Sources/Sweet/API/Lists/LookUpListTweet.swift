//
//  LookUpListTweets.swift
//
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

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
  public func listTweets(listID: String, maxResults: Int = 100, paginationToken: String? = nil)
    async throws -> TweetsResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-tweets/api-reference/get-lists-id-tweets

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/tweets")!

    let queries: [String: String?] = [
      Expansion.key: allTweetExpansion.joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      "pagination_token": paginationToken,
      "max_results": String(maxResults),
    ].filter { $0.value != nil && !$0.value!.isEmpty }

    let headers = getBearerHeaders(type: authorizeType)

    let request: URLRequest = .get(url: url, headers: headers, queries: queries)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(TweetsResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
