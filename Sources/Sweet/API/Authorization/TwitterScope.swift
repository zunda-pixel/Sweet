//
//  TwitterScope.swift
//  
//
//  Created by zunda on 2022/01/20.
//

import Foundation

enum TwitterScope: String, CaseIterable  {
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
}
