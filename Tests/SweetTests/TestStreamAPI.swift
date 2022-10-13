//
//  TestStreamAPI.swift
//

import XCTest

@testable import Sweet

final class TestStreamAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"

  func testFetchStreamRule() async throws {
    let ids = ["1580172994608963584", "1580172994608963585"]

    let streamRules = try await Sweet.test.fetchStreamRule(ids: ids)

    streamRules.forEach {
      print($0)
    }
  }

  func testFetchStream() async throws {
    let stream = TestStream()
    stream.testFilteredStreams()
    let timeoutSeconds: UInt64 = 60 * 3 * 1_000_000_000
    try await Task.sleep(nanoseconds: timeoutSeconds)
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
    let testStream = TestStream()
    testStream.testVolumeStreams()
    let timeoutSeconds: UInt64 = 60 * 3 * 1_000_000_000
    try await Task.sleep(nanoseconds: timeoutSeconds)
  }
}

private class TestStream: NSObject, URLSessionDataDelegate {
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    if let response = try? JSONDecoder().decode(Sweet.TweetResponse.self, from: data) {
      print(response)
    }
  }

  func testVolumeStreams() {
    let request =  Sweet.test.fetchStreamVolume(backfillMinutes: nil)
    let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    let task = session.dataTask(with: request)
    task.resume()
  }

  func testFilteredStreams() {
    let request = Sweet.test.fetchStream(backfillMinutes: nil)
    let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    let task = session.dataTask(with: request)
    task.resume()
  }
}
