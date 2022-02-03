//
//  LookUpListTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchListTweets(listID: String, maxResults: Int? = nil, paginationToken: String? = nil, fields: [TweetField] = []) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-tweets/api-reference/get-lists-id-tweets

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/tweets")!
    
    var queries: [String: String?] = [
      TweetField.key: fields.map(\.rawValue).joined(separator: ","),
      "pagination_token": paginationToken,
    ]
    
    if let maxResults = maxResults {
      queries["max_result"] = String(maxResults)
    }
    
    let headers = getBearerHeaders(type: .User)
    
		let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
						
		let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
		
		return tweetsResponseModel.tweets
  }
}
