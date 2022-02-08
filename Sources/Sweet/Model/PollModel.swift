//
//  PollModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct PollModel {
  let id: String
  let votingStatus: PollStatus
  let endDatetime: Date
  let durationMinutes: Int
  let options: [PollItem]
}

public struct PollItem: Decodable {
    let position: Int
    let label: String
    let votes: Int
}
                    
public enum PollStatus: String {
  case isOpen = "open"
  case isClosed = "closed"
}

extension PollModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case id
    case vodingStatus = "voting_status"
    case endDateTime = "end_datetime"
    case durationMinutes = "duration_minutes"
    case options
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try value.decode(String.self, forKey: .id)
    
    let votingStatus = try value.decode(String.self, forKey: .vodingStatus)
    self.votingStatus = .init(rawValue: votingStatus)!
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    let endDateTime = try value.decode(String.self, forKey: .endDateTime)
    self.endDatetime = formatter.date(from: endDateTime)!
    
    self.durationMinutes = try value.decode(Int.self, forKey: .durationMinutes)
    
    self.options = try value.decode([PollItem].self, forKey: .options)
  }
}
