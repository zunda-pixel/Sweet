//
//  SpaceExpansion.swift
//
//
//  Created by zunda on 2022/04/16.
//

import Foundation

extension Sweet {
  public enum SpaceExpansion: String, CaseIterable, Sendable {
    case invitedUserIDs = "invited_user_ids"
    case speakerIDs = "speaker_ids"
    case creatorID = "creator_id"
    case hostIDs = "host_ids"
    case topicIDs = "topic_ids"
  }
}
