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
      id: String,
      state: SpaceState,
      creatorID: String,
      title: String? = nil,
      hostIDs: [String] = [],
      lang: String? = nil,
      participantCount: Int? = nil,
      isTicketed: Bool? = nil,
      startedAt: Date? = nil,
      updatedAt: Date? = nil,
      createdAt: Date? = nil,
      endedAt: Date? = nil,
      invitedUserIDs: [String] = [],
      scheduledStart: Date? = nil,
      speakerIDs: [String],
      subscriberCount: Int? = nil,
      topicIDs: [String] = []
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
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: Sweet.SpaceField.self)
    self.id = try container.decode(String.self, forKey: .id)

    let state = try container.decode(String.self, forKey: .state)
    self.state = Sweet.SpaceState(rawValue: state)!

    self.creatorID = try container.decode(String.self, forKey: .creatorID)

    let hostIDs = try container.decodeIfPresent([String].self, forKey: .hostIDs)
    self.hostIDs = hostIDs ?? []

    self.isTicketed = try container.decodeIfPresent(Bool.self, forKey: .isTicketed)

    self.participantCount = try container.decodeIfPresent(Int.self, forKey: .participantCount)

    self.lang = try container.decodeIfPresent(String.self, forKey: .lang)
    self.title = try container.decodeIfPresent(String.self, forKey: .title)
    self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
    self.startedAt = try container.decodeIfPresent(Date.self, forKey: .startedAt)
    self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
    self.endedAt = try container.decodeIfPresent(Date.self, forKey: .endedAt)
    self.scheduledStart = try container.decodeIfPresent(Date.self, forKey: .scheduledStart)

    let invitedUserIDs = try container.decodeIfPresent([String].self, forKey: .invitedUserIDs)
    self.invitedUserIDs = invitedUserIDs ?? []

    let speakerIDs = try container.decodeIfPresent([String].self, forKey: .speakerIDs)
    self.speakerIDs = speakerIDs ?? []

    self.subscriberCount = try container.decodeIfPresent(Int.self, forKey: .subscriberCount)

    let topicIDs = try container.decodeIfPresent([String].self, forKey: .topicIDs)
    self.topicIDs = topicIDs ?? []
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.SpaceField.self)
    try container.encode(id, forKey: .id)
    try container.encode(state.rawValue, forKey: .state)
    try container.encode(creatorID, forKey: .creatorID)
    try container.encodeIfPresent(title, forKey: .title)
    try container.encode(hostIDs, forKey: .hostIDs)
    try container.encodeIfPresent(lang, forKey: .lang)
    try container.encodeIfPresent(participantCount, forKey: .participantCount)
    try container.encodeIfPresent(isTicketed, forKey: .isTicketed)
    try container.encodeIfPresent(startedAt, forKey: .startedAt)
    try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
    try container.encodeIfPresent(createdAt, forKey: .createdAt)
    try container.encodeIfPresent(endedAt, forKey: .endedAt)
    try container.encodeIfPresent(scheduledStart, forKey: .scheduledStart)
    try container.encode(invitedUserIDs, forKey: .invitedUserIDs)
    try container.encode(speakerIDs, forKey: .speakerIDs)
    try container.encodeIfPresent(subscriberCount, forKey: .subscriberCount)
    try container.encode(topicIDs, forKey: .topicIDs)
  }
}
