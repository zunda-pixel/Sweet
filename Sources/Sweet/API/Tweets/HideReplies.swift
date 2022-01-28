//
//  HideReplies.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func hideReply(tweetID: String, hidden: Bool) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/hide-replies/api-reference/put-tweets-id-hidden
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/hidden")!
  
    let body = ["hidden": hidden]
    let bodyData = try JSONEncoder().encode(body)
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.put(url: url, body: bodyData, headers: headers)
        
    let hideResponseModel = try JSONDecoder().decode(HideResponseModel.self, from: data)
    
    return hideResponseModel.hidden
  }
}
