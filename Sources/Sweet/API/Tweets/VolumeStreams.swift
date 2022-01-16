//
//  VolumeStreams.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation

extension Sweet {
  func fetchStreamVolume() async throws -> [TweetModel] {
    // TODO 時間がかかりすぎてしまいUnit Testができていない
    
    // https://developer.twitter.com/en/docs/twitter-api/tweets/volume-streams/api-reference/get-tweets-sample-stream
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/sample/stream")!
    
    let headers = bearerHeaders
            
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
        
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}
