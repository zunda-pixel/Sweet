//
//  CountTweetResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct CountTweetResponseModel: Decodable {
  public let countTweetModels : [CountTweetModel]
  
  private enum CodingKeys: String, CodingKey {
    case countTweetModels = "data"
  }
}
