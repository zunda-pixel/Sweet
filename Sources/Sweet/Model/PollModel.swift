//
//  PollModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct PollModel: Hashable, Identifiable {
    public let id: String
    public let votingStatus: PollStatus
    public let endDateTime: Date
    public let durationMinutes: Int
    public let options: [PollItem]
    
    public init(id: String, votingStatus: PollStatus, endDateTime: Date, durationMinutes: Int, options: [PollItem] = []) {
      self.id = id
      self.votingStatus = votingStatus
      self.endDateTime = endDateTime
      self.durationMinutes = durationMinutes
      self.options = options
    }
  }
}

extension Sweet.PollModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case id
    case votingStatus = "voting_status"
    case endDateTime = "end_datetime"
    case durationMinutes = "duration_minutes"
    case options
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try value.decode(String.self, forKey: .id)
    
    let votingStatus = try value.decode(String.self, forKey: .votingStatus)
    self.votingStatus = .init(rawValue: votingStatus)!
    
    let endDateTime = try value.decode(String.self, forKey: .endDateTime)
    self.endDateTime = Sweet.TwitterDateFormatter().date(from: endDateTime)!
    
    self.durationMinutes = try value.decode(Int.self, forKey: .durationMinutes)
    
    self.options = try value.decode([Sweet.PollItem].self, forKey: .options)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(votingStatus.rawValue, forKey: .votingStatus)
    try container.encode(endDateTime, forKey: .endDateTime)
    try container.encode(durationMinutes, forKey: .durationMinutes)
    try container.encode(options, forKey: .options)
  }
}
