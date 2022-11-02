//
//  Sweet+Test.swift
//

import Foundation

@testable import Sweet

extension Sweet {
  static var test: Sweet {
    
    let token: Sweet.AuthorizationType = .oAuth1(
      accessToken: "k1KVviIOklkmjyR6PUDWHrGUH",
      accessSecretToken: "v6OhT1iEYJYKHTsNfJpoWD0L7u2xw8pSLHRD2q0mNn1dvuTc28",
      oAuth1Token: "6330250704653233832-HjUBMK54l7GmN4O6SdgT2WLpW60D3w",
      oAuth2SecretToken: "asu32vKgKOuxyvqoI4FL4rxY5X6iKTsP4wCqPMsLHEylg"
    )
    
    var sweet = Sweet(token: token, config: .default)

    sweet.tweetFields = TweetField.allCases.filter {
      $0 != .promotedMetrics && $0 != .privateMetrics && $0 != .organicMetrics
    }
    sweet.mediaFields = MediaField.allCases.filter {
      $0 != .privateMetrics && $0 != .promotedMetrics && $0 != .organicMetrics
    }
    return sweet
  }
}
