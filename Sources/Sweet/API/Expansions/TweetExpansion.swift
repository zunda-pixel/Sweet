//
//  TweetExpansion.swift
//  
//
//  Created by zunda on 2022/02/05.
//

import Foundation

extension Sweet {
  public enum TweetExpansion: String, CaseIterable, Sendable {
    case authorID = "author_id"
    case entriesMentionsUsername = "entities.mentions.username"
    case inReplyToUserID = "in_reply_to_user_id"
    case referencedTweetsID = "referenced_tweets.id"
    case referencedTweetsIdAuthorID = "referenced_tweets.id.author_id"
  }
}
