//
//  TweetField.swift
//
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/tweet

extension Sweet {
  public enum TweetField: String, Field, Sendable {
    static public let key: String = "tweet.fields"

    case id
    case text
    case attachments
    case authorID = "author_id"
    case contextAnnotations = "context_annotations"
    case conversationID = "conversation_id"
    case createdAt = "created_at"
    case entities
    case geo
    case replyToUserID = "in_reply_to_user_id"
    case lang
    case possiblySensitive = "possibly_sensitive"
    case referencedTweets = "referenced_tweets"
    case replySettings = "reply_settings"
    case source
    case withheld
    case publicMetrics = "public_metrics"
    case privateMetrics = "non_public_metrics"
    case organicMetrics = "organic_metrics"
    case promotedMetrics = "promoted_metrics"
    case editControls = "edit_controls"
    case editHistoryTweetIDs = "edit_history_tweet_ids"
  }
}
