//
//  Expansion.swift
//
//
//  Created by zunda on 2022/01/31.
//

public struct Expansion: Sendable {
  static var key: String = "expansions"
}

extension Sweet {
  var allTweetExpansion: [String] {
    let allExpansions: [String] =
      tweetExpansions.map(\.rawValue) + pollExpansions.map(\.rawValue)
      + mediaExpansions.map(\.rawValue) + placeExpansions.map(\.rawValue)
    return allExpansions
  }

  var allUserExpansion: [String] {
    let allExpansions: [String] = userExpansions.map(\.rawValue)
    return allExpansions
  }

  var allDirectMessageExpansion: [String] {
    let allExpansions: [String] =
      directMesssageExpansions.map(\.rawValue) + mediaExpansions.map(\.rawValue)
    return allExpansions
  }

  var allListExpansion: [String] {
    let allExpansions: [String] = listExpansions.map(\.rawValue)
    return allExpansions
  }

  var allSpaceExpansion: [String] {
    let allExpansions: [String] = spaceExpansions.map(\.rawValue)
    return allExpansions
  }
}
