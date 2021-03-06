//
//  SpaceModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Space Model
  public struct SpaceModel: Hashable, Identifiable {
    public let id: String
    public let state: SpaceState
    public let creatorID: String
    public let title: String?
    public let hostIDs: [String]
    public let lang: String?
    public let participantCount: Int?
    public let isTicketed: Bool?
    public let startedAt: Date?
    public let updatedAt: Date?
    public let createdAt: Date?
    public let endedAt: Date?
    public let invitedUserIDs: [String]
    public let scheduledStart: Date?
    public let speakerIDs: [String]
    public let subscriberCount: Int?
    public let topicIDs: [String]
    
    public init(id: String, state: SpaceState, creatorID: String, title: String? = nil, hostIDs: [String] = [],
                lang: String? = nil, participantCount: Int? = nil, isTicketed: Bool? = nil,
                startedAt: Date? = nil, updatedAt: Date? = nil, createdAt: Date? = nil, endedAt: Date? = nil,
                invitedUserIDs: [String] = [], scheduledStart: Date? = nil, speakerIDs: [String],
                subscriberCount: Int? = nil, topicIDs: [String] = []) {
      self.id = id
      self.state = state
      self.creatorID = creatorID
      self.title = title
      self.hostIDs = hostIDs
      self.lang = lang
      self.participantCount = participantCount
      self.isTicketed = isTicketed
      self.startedAt = startedAt
      self.updatedAt = updatedAt
      self.createdAt = createdAt
      self.endedAt = endedAt
      self.invitedUserIDs = invitedUserIDs
      self.scheduledStart = scheduledStart
      self.speakerIDs = speakerIDs
      self.subscriberCount = subscriberCount
      self.topicIDs = topicIDs
    }
  }
}

extension Sweet.SpaceModel: Decodable {
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: Sweet.SpaceField.self)
    self.id = try values.decode(String.self, forKey: .id)
    
    let state = try values.decode(String.self, forKey: .state)
    self.state = .init(rawValue: state)!
    
    self.creatorID = try values.decode(String.self, forKey: .creatorID)
    
    
    let hostIDs = try? values.decode([String].self, forKey: .hostIDs)
    self.hostIDs = hostIDs ?? []
    
    self.isTicketed = try? values.decode(Bool.self, forKey: .isTicketed)

    self.participantCount = try? values.decode(Int.self, forKey: .participantCount)
        
    self.lang = try? values.decode(String.self, forKey: .lang)
    self.title = try? values.decode(String.self, forKey: .title)
    
    let formatter = Sweet.TwitterDateFormatter()
    
    if let createdAt = try? values.decode(String.self, forKey: .createdAt) {
      self.createdAt = formatter.date(from: createdAt)
    } else {
      self.createdAt = nil
    }
    
    if let startedAt = try? values.decode(String.self, forKey: .startedAt) {
      self.startedAt = formatter.date(from: startedAt)
    } else {
      self.startedAt = nil
    }
    
    if let updatedAt = try? values.decode(String.self, forKey: .updatedAt) {
      self.updatedAt = formatter.date(from: updatedAt)
    } else {
      self.updatedAt = nil
    }
    
    if let endedAt = try? values.decode(String.self, forKey: .endedAt) {
      self.endedAt = formatter.date(from: endedAt)
    } else {
      self.endedAt = nil
    }
    
    if let scheduledStart = try? values.decode(String.self, forKey: .scheduledStart) {
      self.scheduledStart = formatter.date(from: scheduledStart)
    } else {
      self.scheduledStart = nil
    }
    
    let invitedUserIDs = try? values.decode([String].self, forKey: .invitedUserIDs)
    self.invitedUserIDs = invitedUserIDs ?? []
    
    let speakerIDs = try? values.decode([String].self, forKey: .speakerIDs)
    self.speakerIDs = speakerIDs ?? []
    
    self.subscriberCount = try? values.decode(Int.self, forKey: .subscriberCount)
    
    let topicIDs = try? values.decode([String].self, forKey: .topicIDs)
    self.topicIDs = topicIDs ?? []
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.SpaceField.self)
    try container.encode(id, forKey: .id)
    try container.encode(state.rawValue, forKey: .state)
    try container.encode(creatorID, forKey: .creatorID)
    try container.encode(title, forKey: .title)
    try container.encode(hostIDs, forKey: .hostIDs)
    try container.encode(lang, forKey: .lang)
    try container.encode(participantCount, forKey: .participantCount)
    try container.encode(isTicketed, forKey: .isTicketed)
    try container.encode(startedAt, forKey: .startedAt)
    try container.encode(updatedAt, forKey: .updatedAt)
    try container.encode(createdAt, forKey: .creatorID)
    try container.encode(endedAt, forKey: .endedAt)
    try container.encode(invitedUserIDs, forKey: .invitedUserIDs)
    try container.encode(scheduledStart, forKey: .scheduledStart)
    try container.encode(speakerIDs, forKey: .speakerIDs)
    try container.encode(subscriberCount, forKey: .subscriberCount)
    try container.encode(topicIDs, forKey: .topicIDs)
  }
}
