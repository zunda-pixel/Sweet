//
//  UserField.swift
//  
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/user

public enum UserField: String, Field {
  static public var key: String { "user.fields" }
  
  case id
  case name
  case username
  case createdAt = "created_at"
  case description
  case entities
  case location
  case pinnedTweetID = "pinned_tweet_id"
  case profileImageURL = "profile_image_url"
  case protected
  case publicMetrics = "public_metrics"
  case url
  case verified
  case withheld
}
