//
//  SpaceField.swift
//  
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/space

extension Sweet {
  public enum SpaceField: String, Field {
    static public var key: String { "space.fields" }
    
    case id
    case state
    case creatorID = "creator_id"
    case createdAt = "created_at"
    case endedAt = "ended_at"
    case hostIDs = "host_ids"
    case lang
    case isTicketed = "is_ticketed"
    case invitedUserIDs = "invited_user_ids"
    case participantCount = "participant_count"
    case scheduledStart = "scheduled_start"
    case speakeIDs = "speaker_ids"
    case startedAt = "started_at"
    case title
    case topicIDs = "topic_ids"
    case updatedAt = "updated_at"
    case subscriberCount = "subscriber_count"
  }
}
