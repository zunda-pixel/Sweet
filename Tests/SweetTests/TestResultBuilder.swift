//
//  TestResultBuilder.swift
//

import Foundation
import XCTest

@testable import Sweet

final class TestResultBuilder: XCTestCase {
  func testDictionary() {
    let value1: String? = "value1"
    let value4: String? = nil

    @DictionaryBuilder<String, String>
    var values1: [String: String] {
      if let value1 {
        ["key1": value1]
      }

      [
        "key2": "value2",
        "key3": "value3",
      ]

      if let value4 {
        ["key4": value4]
      }
    }

    let values2: [String: String] = [
      "key1": "value1",
      "key2": "value2",
      "key3": "value3",
    ]

    XCTAssertEqual(values1, values2)
  }
}
