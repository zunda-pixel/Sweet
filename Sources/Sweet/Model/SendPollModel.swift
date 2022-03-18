//
//  SendPollModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

public struct SendPollModel {
  public let options: [String]
  public let durationMinutes: Int
}

extension SendPollModel: Encodable {
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
