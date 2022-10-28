//
//  NewDirectMessage.swift
//

import Foundation

extension Sweet {
  public struct NewDirectMessage: Codable, Sendable {
    public let conversationType: ConversationType
    public let message: Message
    public let participantIDs: [String]
    
    public init(conversationType: ConversationType, message: Message, participantIDs: [String] = []) {
      self.conversationType = conversationType
      self.message = message
      self.participantIDs = participantIDs
    }
    
    private enum CodingKeys: String, CodingKey {
      case conversationType = "conversation_type"
      case message
      case participantIDs = "participant_ids"
    }
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      let conversationType = try container.decode(String.self, forKey: .conversationType)
      self.conversationType = .init(rawValue: conversationType)!
      self.participantIDs = try container.decode([String].self, forKey: .participantIDs)
      self.message = try container.decode(Message.self, forKey: .message)
    }
    
    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(conversationType.rawValue, forKey: .conversationType)
      try container.encode(participantIDs, forKey: .participantIDs)
      try container.encode(message, forKey: .message)
    }
  }
}

extension Sweet.NewDirectMessage {
  public enum ConversationType: String, Sendable {
    case group = "Group"
  }
}

extension Sweet.NewDirectMessage {
  public struct Message: Codable, Sendable {
    public let text: String?
    public let attachments: [Attachment]
    
    public init(text: String? = nil, attachments: [Attachment] = []) {
      self.text = text
      self.attachments = attachments
    }
    
    private enum CodingKeys: String, CodingKey {
      case text
      case attachments
    }
  }
}

extension Sweet.NewDirectMessage.Message {
  public struct Attachment: Codable, Sendable {
    public let mediaID: String
    
    public init(mediaID: String) {
      self.mediaID = mediaID
    }
    
    private enum CodingKeys: String, CodingKey {
      case mediaID = "media_id"
    }
  }
}
