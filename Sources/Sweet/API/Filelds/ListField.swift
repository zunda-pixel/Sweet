//
//  ListField.swift
//  
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/lists

extension Sweet {
  public enum ListField: String, Field, Sendable {
    static public var key: String { "list.fields" }
    
    case id
    case name
    case createdAt = "created_at"
    case description
    case followerCount = "follower_count"
    case memberCount = "member_count"
    case isPrivate = "private"
    case ownerID = "owner_id"
  }
}
