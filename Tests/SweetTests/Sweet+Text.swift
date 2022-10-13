//
//  Sweet+Text.swift
//

import Foundation

@testable import Sweet

extension Sweet {
  static var test: Sweet {
    let bearerTokenUser = ""
    let bearerTokenApp = ""
    var sweet = Sweet(app: bearerTokenApp, user: bearerTokenUser, session: .shared)
    sweet.authorizeType = .app
    sweet.tweetFields = TweetField.allCases.filter {
      $0 != .promotedMetrics && $0 != .privateMetrics && $0 != .organicMetrics
    }
    sweet.mediaFields = MediaField.allCases.filter {
      $0 != .privateMetrics && $0 != .promotedMetrics && $0 != .organicMetrics
    }
    return sweet
  }
}
