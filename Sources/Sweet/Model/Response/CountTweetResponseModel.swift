//
//  CountTweetResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct CountTweetResponseModel {
  public let countTweetModels : [CountTweetModel]
}

extension CountTweetResponseModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case countTweetModels = "data"
  }
}
