//
//  QuoteTweets.swift
//  
//
//  Created by zunda on 2022/03/20.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Fetch Quote Tweets by Tweet ID
  /// - Parameters:
  ///   - tweetID: Tweet ID
  ///   - paginationToken: Next Page Token for loading more than maxResults Count
  ///   - maxResults: Max Tweet Count
  /// - Returns: Tweets
  func fetchQuoteTweets(source tweetID: String, paginationToken: String? = nil, maxResults: Int = 10) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/quote-tweets/api-reference/get-tweets-id-quote_tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/quote_tweets")!
    
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
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(TweetsResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
