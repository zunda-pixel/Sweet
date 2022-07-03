//
//  SendPollModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  /// Post Poll Model
  public struct PostPollModel {
    public var options: [String]
    public var durationMinutes: Int
    
    public init(options: [String] = [], durationMinutes: Int) {
      self.options = options
      self.durationMinutes = durationMinutes
    }
  }
}

extension Sweet.PostPollModel: Encodable {
  private enum CodingKeys: String, CodingKey {
    case options
    case durationMinutes = "duration_minutes"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(options, forKey: .options)
    try container.encode(durationMinutes, forKey: .durationMinutes)
  }
}
