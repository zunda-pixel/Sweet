//
//  DirectMessageModel.swift
//

import Foundation

extension Sweet {
  public struct DirectMessageModel: Codable, Sendable, Identifiable, Hashable {
    public let eventType: Sweet.DirectMessageEventType
    public let id: String
    public let text: String
    public let conversationID: String?
    public let createdAt: Date?
    public let senderID: String?
    public let attachments: DirectMessageAttachmentsModel?
    public let referencedTweets: [DirectMessageReferencedTweetModel]

    public init(
      eventType: DirectMessageEventType, id: String, text: String, conversationID: String?,
      createdAt: Date?, senderID: String?, attachments: DirectMessageAttachmentsModel? = nil,
      referencedTweets: [DirectMessageReferencedTweetModel] = []
    ) {
      self.eventType = eventType
      self.id = id
      self.text = text
      self.conversationID = conversationID
      self.createdAt = createdAt
      self.senderID = senderID
      self.attachments = attachments
      self.referencedTweets = referencedTweets
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: DirectMessageField.self)

      let eventType = try container.decode(String.self, forKey: .eventType)
      self.eventType = .init(rawValue: eventType)!

      self.id = try container.decode(String.self, forKey: .id)
      self.text = try container.decode(String.self, forKey: .text)
      self.conversationID = try container.decodeIfPresent(String.self, forKey: .conversationID)

      let createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
      self.createdAt = createdAt.map { Sweet.TwitterDateFormatter().date(from: $0)! }

      self.senderID = try container.decodeIfPresent(String.self, forKey: .senderID)

      self.attachments = try container.decodeIfPresent(
        DirectMessageAttachmentsModel.self,
        forKey: .attachments
      )

      let referencedTweets = try container.decodeIfPresent(
        [DirectMessageReferencedTweetModel].self,
        forKey: .referencedTweets
      )
      
      self.referencedTweets = referencedTweets ?? []
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: DirectMessageField.self)
      try container.encode(eventType.rawValue, forKey: .eventType)
      try container.encode(id, forKey: .id)
      try container.encode(text, forKey: .text)
      try container.encodeIfPresent(conversationID, forKey: .conversationID)

      if let createdAt {
        try container.encode(TwitterDateFormatter().string(from: createdAt), forKey: .createdAt)
      }

      try container.encodeIfPresent(senderID, forKey: .senderID)
      try container.encodeIfPresent(attachments, forKey: .attachments)
      try container.encodeIfPresent(referencedTweets, forKey: .referencedTweets)
    }
  }
}
