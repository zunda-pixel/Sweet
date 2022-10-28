//
//  DirectMessageExpansion.swift
//

import Foundation

extension Sweet {
  public enum DirectMessageExpansion: String, CaseIterable, Sendable {
    case senderID = "sender_id"
    case participantIDs = "participant_ids"
  }
}
