//
//  CountTweetResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct CountTweetResponseModel {
  public let countTweets : [CountTweetModel]
  public let meta: CountTweetMetaModel
}

extension CountTweetResponseModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case countTweets = "data"
    case meta
  }
}
