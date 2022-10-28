//
//  DirectMessageEventType.swift
//

import Foundation

extension Sweet {
  public enum DirectMessageEventType: String, Sendable {
    case messageCreate = "MessageCreate"
    case participatnsJoin = "ParticipantsJoin"
    case participantsLeave = "ParticipantsLeave"
  }
}
