//
//  CountTweetResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Count Tweet Respose
  public struct CountTweetResponse {
    public let countTweets : [CountTweetModel]
    public let meta: CountTweetMetaModel
  }
}

extension Sweet.CountTweetResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case countTweets = "data"
    case meta
  }
}
