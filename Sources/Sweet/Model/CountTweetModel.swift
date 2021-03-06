//
//  CountTweetModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Count Tweet Model
  public struct CountTweetModel: Hashable {
    public let countTweet: Int
    public let startDate: Date
    public let endDate: Date
    
    public init(countTweet: Int, startDate: Date, endDate: Date) {
      self.countTweet = countTweet
      self.startDate = startDate
      self.endDate = endDate
    }
  }
}

extension Sweet.CountTweetModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case countTweet = "tweet_count"
    case startDate = "start"
    case endDate = "end"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.countTweet = try values.decode(Int.self, forKey: .countTweet)
    
    let formatter = Sweet.TwitterDateFormatter()
    
    let startDateString = try values.decode(String.self, forKey: .startDate)
    self.startDate = formatter.date(from: startDateString)!
    
    let endDateString = try values.decode(String.self, forKey: .endDate)
    self.endDate = formatter.date(from: endDateString)!
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(countTweet, forKey: .countTweet)
    try container.encode(startDate, forKey: .startDate)
    try container.encode(endDate, forKey: .endDate)
  }
}
