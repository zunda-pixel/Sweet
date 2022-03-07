//
//  CountTweetModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct CountTweetModel {
  public let countTweet: Int
  public let startDate: Date
  public let endDate: Date
  
  public init(countTweet: Int, startDate: Date, endDate: Date) {
    self.countTweet = countTweet
    self.startDate = startDate
    self.endDate = endDate
  }
}

extension CountTweetModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case countTweet = "tweet_count"
    case startDate = "start"
    case endDate = "end"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.countTweet = try values.decode(Int.self, forKey: .countTweet)
    
    let formatter = TwitterDateFormatter()
    
    let startDateString = try values.decode(String.self, forKey: .startDate)
    self.startDate = formatter.date(from: startDateString)!
    
    let endDateString = try values.decode(String.self, forKey: .endDate)
    self.endDate = formatter.date(from: endDateString)!
  }
}
