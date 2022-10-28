//
//  DirectMessageEventType.swift
//  
//
//  Created by zunda on 2022/10/28.
//

import Foundation

extension Sweet {
  enum DirectMessageEventType: String, Sendable {
    case messageCreate = "MessageCreate"
    case participatnsJoin = "ParticipantsJoin"
    case participantsLeave = "ParticipantsLeave"
  }
}
