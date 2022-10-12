//
//  AccessScope.swift
//

import Foundation

extension Sweet {
  /// Access Scope
  /// https://developer.twitter.com/en/docs/authentication/oauth-2-0/authorization-code
  public enum AccessScope: String, CaseIterable {
    case tweetRead = "tweet.read"
    case tweetWrite = "tweet.write"
    case tweetModerateWrite = "tweet.moderate.write"
    
    case usersRead = "users.read"
    
    case followsRead = "follows.read"
    case followWrite = "follows.write"
    
    case offlineAccess = "offline.access"
    
    case spaceRead = "space.read"
    
    case muteRead = "mute.read"
    case muteWrite = "mute.write"
    
    case likeRead = "like.read"
    case likeWrite = "like.write"
    
    case listRead = "list.read"
    case listWrite = "list.write"
    
    case blockRead = "block.read"
    case blockWrite = "block.write"
    
    case bookmarkRead = "bookmark.read"
    case bookmarkWrite = "bookmark.write"
  }
}
