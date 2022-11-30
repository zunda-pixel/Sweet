//
//  DirectMessageResultResponse.swift
//

import Foundation

extension Sweet {
  public struct DirectMessageResultResponse: Codable, Sendable {
    public let conversationID: String
    public let eventID: String

    public init(conversationID: String, eventID: String) {
      self.conversationID = conversationID
      self.eventID = eventID
    }

    private enum DataCodingKeys: CodingKey {
      case data
    }

    private enum CodingKeys: String, CodingKey {
      case conversationID = "dm_conversation_id"
      case eventID = "dm_event_id"
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: DataCodingKeys.self)

      let directMessageContainer = try container.nestedContainer(
        keyedBy: CodingKeys.self, forKey: .data)
      self.conversationID = try directMessageContainer.decode(String.self, forKey: .conversationID)
      self.eventID = try directMessageContainer.decode(String.self, forKey: .eventID)
    }
  }
}
