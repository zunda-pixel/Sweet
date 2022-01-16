//
//  HideReplies.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation

extension Sweet {
  func hideReply(tweetID: String, hidden: Bool) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/hide-replies/api-reference/put-tweets-id-hidden
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/hidden")!
  
    let body = ["hidden": hidden]
    let bodyData = try JSONEncoder().encode(body)
    
    let httpMethod: HTTPMethod = .PUT

    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
        
    let hideResponseModel = try JSONDecoder().decode(HideResponseModel.self, from: data)
    
    return hideResponseModel.hidden
  }
}
