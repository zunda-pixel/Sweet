//
//  DirectMessageEventType.swift
//

import Foundation

extension Sweet {
  public enum DirectMessageEventType: String, Sendable {
    case messageCreate = "MessageCreate"
    case participantsJoin = "ParticipantsJoin"
    case participantsLeave = "ParticipantsLeave"
  }
}
