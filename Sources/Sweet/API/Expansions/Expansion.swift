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
}
