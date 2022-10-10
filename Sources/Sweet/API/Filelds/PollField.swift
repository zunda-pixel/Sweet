//
//  PollField.swift
//  
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/poll

extension Sweet {
  public enum PollField: String, Field, Sendable {
    static public var key: String { "poll.fields" }
    
    case id
    case durationMinutes = "duration_minutes"
    case endDateTime = "end_datetime"
    case votingStatus = "voting_status"
    case options
  }
}
