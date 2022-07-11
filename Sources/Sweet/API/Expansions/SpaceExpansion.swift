//
//  SpaceExpansion.swift
//
//
//  Created by zunda on 2022/04/16.
//

import Foundation

extension Sweet {
  public enum SpaceExpansion: String, CaseIterable {
    case ownerID = "owner_id"
    case authorID = "author_id"
    case invitedUserIDs = "invited_user_ids"
    case speakerIDs = "speaker_id"
    case creatorID = "creator_id"
    case hostIDs = "host_ids"
    case topicsIDs = "topics_ids"
  }
}
