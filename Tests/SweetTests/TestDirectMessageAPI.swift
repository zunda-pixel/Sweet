//
//  TestDirectMessageAPI.swift
//

import XCTest

@testable import Sweet

final class TestDirectMessageAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"

  func testDirectMessageEvents() async throws {
    let response = try await Sweet.test.directMessageEvents(eventType: .messageCreate)
    print(response)
  }

  func testDirectMessageConversationsWithParticipantID() async throws {
    let participantID = "3014184570"

    let response = try await Sweet.test.directMessageConversations(participantID: participantID)

    print(response)
  }

  func testDirectMessageConversationsWithConversationID() async throws {
    let conversationID = "1585874950879334400"

    let response = try await Sweet.test.directMessageConversations(conversationID: conversationID)

    print(response)
  }

  func testCreateDirectMessageGroup() async throws {
    let dm = Sweet.NewDirectMessage(
      message: .init(text: "Hello Zunda"), conversationType: .group,
      participantIDs: ["3014184570", "1048032521361866752"])

    let response = try await Sweet.test.createDirectMessageGroup(directMessage: dm)

    print(response)
  }

  func testPostDirectMessageWithConversationID() async throws {
    let conversationID = "1585874950879334400"

    let response = try await Sweet.test.postDirectMessage(
      conversationID: conversationID, message: .init(text: "second Text"))

    print(response)
  }

  func testPostDirectMessageWithParticipantID() async throws {
    let participantID = "3014184570"

    let response = try await Sweet.test.postDirectMessage(
      participantID: participantID, message: .init(text: "second Text"))

    print(response)
  }
}
