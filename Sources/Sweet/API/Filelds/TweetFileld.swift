//
//  TweetField.swift
//  
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/tweet

public enum TweetField: String, Field {
  public var key: String { "tweet.fields" }
  
  case attachments
  case authorID = "author_id"
  case contextAnnotations = "context_annotations"
  case conversationID = "conversation_id"
  case createdAt = "created_at"
  case entities
  case geo
  case inReplyToUserID = "in_reply_to_user_id"
  case lang
  case nonPublicMetrics = "non_public_metrics"
  case organicMetrics = "organic_metrics"
  case possiblySensitive = "possibly_sensitive"
  case promotedMetrics = "promoted_metrics"
  case publicMetrics = "public_metrics"
  case referencedTweets = "referenced_tweets"
  case replySettings = "reply_settings"
  case source
  case withheld
}
