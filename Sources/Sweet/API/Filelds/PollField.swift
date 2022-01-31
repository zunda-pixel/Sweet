//
//  PollField.swift
//  
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/poll

public enum PollField: String, Field {
  public var key: String { "poll.fields" }
  
  case durationMinutes = "duration_minutes"
  case endDatetime = "end_datetime"
  case votingStatus = "voting_status"
}
