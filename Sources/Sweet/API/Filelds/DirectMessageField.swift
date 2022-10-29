//
//  DirectMessageField.swift
//

import Foundation

extension Sweet {

  public enum DirectMessageField: String, Field, Sendable {
    static public let key: String = "dm_event.fields"

    case id
    case text
    case eventType = "event_type"
    case createdAt = "created_at"
    case conversationID = "dm_conversation_id"
    case senderID = "sender_id"
    case participantIDs = "participant_ids"
    case referencedTweets = "referenced_tweets"
    case attachments
  }
}
