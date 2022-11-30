//
//  SpaceModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Space Model
  public struct SpaceModel: Hashable, Identifiable, Sendable {
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

    public init(
      id: String, state: SpaceState, creatorID: String, title: String? = nil,
      hostIDs: [String] = [],
      lang: String? = nil, participantCount: Int? = nil, isTicketed: Bool? = nil,
      startedAt: Date? = nil, updatedAt: Date? = nil, createdAt: Date? = nil, endedAt: Date? = nil,
      invitedUserIDs: [String] = [], scheduledStart: Date? = nil, speakerIDs: [String],
      subscriberCount: Int? = nil, topicIDs: [String] = []
    ) {
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

extension Sweet.SpaceModel: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Sweet.SpaceField.self)
    self.id = try container.decode(String.self, forKey: .id)

    let state = try container.decode(String.self, forKey: .state)
    self.state = .init(rawValue: state)!

    self.creatorID = try container.decode(String.self, forKey: .creatorID)

    let hostIDs = try container.decodeIfPresent([String].self, forKey: .hostIDs)
    self.hostIDs = hostIDs ?? []

    self.isTicketed = try container.decodeIfPresent(Bool.self, forKey: .isTicketed)

    self.participantCount = try container.decodeIfPresent(Int.self, forKey: .participantCount)

    self.lang = try container.decodeIfPresent(String.self, forKey: .lang)
    self.title = try container.decodeIfPresent(String.self, forKey: .title)

    let formatter = Sweet.TwitterDateFormatter()

    let createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    self.createdAt = createdAt.map { formatter.date(from: $0)! }

    let startedAt = try container.decodeIfPresent(String.self, forKey: .startedAt)
    self.startedAt = startedAt.map { formatter.date(from: $0)! }

    let updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
    self.updatedAt = updatedAt.map { formatter.date(from: $0)! }

    let endedAt = try container.decodeIfPresent(String.self, forKey: .endedAt)
    self.endedAt = endedAt.map { formatter.date(from: $0)! }

    let scheduledStart = try container.decodeIfPresent(String.self, forKey: .scheduledStart)
    self.scheduledStart = scheduledStart.map { formatter.date(from: $0)! }

    let invitedUserIDs = try container.decodeIfPresent([String].self, forKey: .invitedUserIDs)
    self.invitedUserIDs = invitedUserIDs ?? []

    let speakerIDs = try container.decodeIfPresent([String].self, forKey: .speakerIDs)
    self.speakerIDs = speakerIDs ?? []

    self.subscriberCount = try container.decodeIfPresent(Int.self, forKey: .subscriberCount)

    let topicIDs = try container.decodeIfPresent([String].self, forKey: .topicIDs)
    self.topicIDs = topicIDs ?? []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.SpaceField.self)
    try container.encode(id, forKey: .id)
    try container.encode(state.rawValue, forKey: .state)
    try container.encode(creatorID, forKey: .creatorID)
    try container.encodeIfPresent(title, forKey: .title)
    try container.encode(hostIDs, forKey: .hostIDs)
    try container.encodeIfPresent(lang, forKey: .lang)
    try container.encodeIfPresent(participantCount, forKey: .participantCount)
    try container.encodeIfPresent(isTicketed, forKey: .isTicketed)
    let formatter = Sweet.TwitterDateFormatter()

    if let startedAt {
      try container.encode(formatter.string(from: startedAt), forKey: .startedAt)
    }

    if let updatedAt {
      try container.encode(formatter.string(from: updatedAt), forKey: .updatedAt)
    }

    if let createdAt {
      try container.encode(formatter.string(from: createdAt), forKey: .creatorID)
    }

    if let endedAt {
      try container.encode(formatter.string(from: endedAt), forKey: .endedAt)
    }

    try container.encode(invitedUserIDs, forKey: .invitedUserIDs)

    if let scheduledStart {
      try container.encode(formatter.string(from: scheduledStart), forKey: .scheduledStart)
    }

    try container.encode(speakerIDs, forKey: .speakerIDs)
    try container.encodeIfPresent(subscriberCount, forKey: .subscriberCount)
    try container.encode(topicIDs, forKey: .topicIDs)
  }
}
