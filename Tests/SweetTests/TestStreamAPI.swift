//
//  TestStreamAPI.swift
//

import XCTest

@testable import Sweet

final class TestStreamAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"

  func testFetchStreamRule() async throws {
    let ids = ["1580172994608963584", "1580172994608963585"]

    let streamRules = try await Sweet.test.streamRule(ids: ids)

    streamRules.forEach {
      print($0)
    }
  }

  func testFetchStream() async throws {
    for try await response in Sweet.test.filteredStream() {
      print(response.tweet.text)
    }
  }

  func testCreateStreamRule() async throws {
    let streamModels: [Sweet.StreamRuleModel] = [
      .init(value: "zunda633", tag: "tag1"),
      .init(value: "mikan323", tag: "tag2"),
    ]

    let streamRuleModels = try await Sweet.test.createStreamRule(streamModels)

    print(streamRuleModels)
  }

  func testDeleteStreamRuleByID() async throws {
    let ids = [
      "1579285720509710336",
      "1579285720509710337",
    ]

    try await Sweet.test.deleteStreamRule(ids: ids)
  }

  func testDeleteStreamRuleByValue() async throws {
    let values = [
      "meme",
      "cat has:media",
    ]

    try await Sweet.test.deleteStreamRule(values: values)
  }

  func testFetchStreamVolume() async throws {
    for try await response in Sweet.test.volumeStream() {
      print(response.tweet.text)
    }
  }
}
