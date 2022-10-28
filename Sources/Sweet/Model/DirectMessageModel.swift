//
//  DirectMessageModel.swift
//

import Foundation

extension Sweet {
  public struct DirectMessageModel: Codable, Sendable, Identifiable {
    public let eventType: Sweet.DirectMessageEventType
    public let id: String
    public let text: String
    public let conversationID: String?
    public let createdAt: Date?
    public let senderID: String?
    public let attachments: DirectMessageAttachmentsModel?
    public let referencedTweets: [DirectMessageReferencedTweetModel]
    
    public init(eventType: DirectMessageEventType, id: String, text: String, conversationID: String, createdAt: Date, senderID: String, attachments: DirectMessageAttachmentsModel? = nil, referencedTweets: [DirectMessageReferencedTweetModel] = []) {
      self.eventType = eventType
      self.id = id
      self.text = text
      self.conversationID = conversationID
      self.createdAt = createdAt
      self.senderID = senderID
      self.attachments = attachments
      self.referencedTweets = referencedTweets
    }
    
    private enum CodingKeys: String, CodingKey {
      case eventType = "event_type"
      case id
      case text
      case conversationID = "dm_conversation_id"
      case createdAt = "created_at"
      case senderID = "sender_id"
      case attachments
      case referencedTweets = "referenced_tweets"
    }
    
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      let eventType = try container.decode(String.self, forKey: .eventType)
      self.eventType = .init(rawValue: eventType)!
      
      self.id = try container.decode(String.self, forKey: .id)
      self.text = try container.decode(String.self, forKey: .text)
      self.conversationID = try container.decodeIfPresent(String.self, forKey: .conversationID)
            
      if let createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) {
        self.createdAt = Sweet.TwitterDateFormatter().date(from: createdAt)!
      } else {
        self.createdAt = nil
      }
      
      self.senderID = try container.decodeIfPresent(String.self, forKey: .senderID)
      
      self.attachments = try container.decodeIfPresent(DirectMessageAttachmentsModel.self, forKey: .attachments)
      
      let referencedTweets = try container.decodeIfPresent([DirectMessageReferencedTweetModel].self, forKey: .referencedTweets)
      self.referencedTweets = referencedTweets ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
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
