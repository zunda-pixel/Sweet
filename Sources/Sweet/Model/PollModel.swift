//
//  PollModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct PollModel {
    public let id: String
    public let votingStatus: PollStatus
    public let endDateTime: Date
    public let durationMinutes: Int
    public let options: [PollItem]
  }
}

extension Sweet.PollModel: Decodable {
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
    
    let endDateTime = try value.decode(String.self, forKey: .endDateTime)
    self.endDateTime = Sweet.TwitterDateFormatter().date(from: endDateTime)!
    
    self.durationMinutes = try value.decode(Int.self, forKey: .durationMinutes)
    
    self.options = try value.decode([Sweet.PollItem].self, forKey: .options)
  }
}
