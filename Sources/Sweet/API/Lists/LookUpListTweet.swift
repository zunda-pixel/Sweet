//
//  LookUpListTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

extension Sweet {
  func fetchListTweets(listID: String) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/lists/list-tweets/api-reference/get-lists-id-tweets

    let url: URL = .init(string: "https://api.twitter.com/2/lists/\(listID)/tweets")!

    let httpMethod: HTTPMethod = .GET

		let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
						
		let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
						
		let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
		
		return tweetsResponseModel.tweets
  }
}