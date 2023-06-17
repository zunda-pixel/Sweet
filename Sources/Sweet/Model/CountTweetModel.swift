//
//  CountTweetModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Count Tweet Model
  public struct CountTweetModel: Hashable, Sendable {
    public let countTweet: Int
    public let startDate: Date
    public let endDate: Date

    public init(
      countTweet: Int,
      startDate: Date,
      endDate: Date
    ) {
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

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.countTweet = try container.decode(Int.self, forKey: .countTweet)
    self.startDate = try container.decode(Date.self, forKey: .startDate)
    self.endDate = try container.decode(Date.self, forKey: .endDate)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(countTweet, forKey: .countTweet)
    try container.encode(startDate, forKey: .startDate)
    try container.encode(endDate, forKey: .endDate)
  }
}
