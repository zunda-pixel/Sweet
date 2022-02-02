//
//  ListFiled.swift
//  
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/lists

public enum ListFiled: String, Field {
  static public var key: String { "list.fields" }
  
  case createdAt = "created_at"
  case description
  case followerCount = "follower_count"
  case memberCount = "member_count"
  case isPrivate = "private"
  case ownerID = "owner_id"
}
