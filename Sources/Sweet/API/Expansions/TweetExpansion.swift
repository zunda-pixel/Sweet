//
//  TweetExpansion.swift
//  
//
//  Created by zunda on 2022/01/31.
//

public enum TweetExpansion: String, Expansion {
  case attachmentsPollIDs = "attachments.poll_ids"
  case attachmentsMediaKeys = "attachments.media_keys"
  case authorID = "author_id"
  case entriesMentionsUsername = "entities.mentions.username"
  case geoPlaceID = "geo.place_id"
  case inReplyToUserID = "in_reply_to_user_id"
  case referencedTweetsID = "referenced_tweets.id"
  case referencedTweetsIdAuthorID = "referenced_tweets.id.author_id"
}
