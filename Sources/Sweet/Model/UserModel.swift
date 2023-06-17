//
//  UserModel.swift
//
//
//  Created by zunda on 2022/01/14.
//

import Foundation

extension Sweet {
  /// User Model
  public struct UserModel: Hashable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let userName: String
    public let verified: Bool?
    public let profileImageURL: URL?
    public let description: String?
    public let protected: Bool?
    public let url: URL?
    public let createdAt: Date?
    public let location: String?
    public let pinnedTweetID: String?
    public let metrics: UserPublicMetrics?
    public let withheld: WithheldModel?
    public let entity: UserEntityModel?

    public init(
      id: String,
      name: String,
      userName: String,
      verified: Bool? = nil,
      profileImageURL: URL? = nil,
      description: String? = nil,
      protected: Bool? = nil,
      url: URL? = nil,
      createdAt: Date? = nil,
      location: String? = nil,
      pinnedTweetID: String? = nil,
      metrics: UserPublicMetrics? = nil,
      withheld: WithheldModel? = nil,
      entity: UserEntityModel? = nil
    ) {
      self.id = id
      self.name = name
      self.userName = userName
      self.verified = verified
      self.profileImageURL = profileImageURL
      self.description = description
      self.protected = protected
      self.url = url
      self.createdAt = createdAt
      self.location = location
      self.pinnedTweetID = pinnedTweetID
      self.metrics = metrics
      self.withheld = withheld
      self.entity = entity
    }
  }
}

extension Sweet.UserModel: Codable {
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: Sweet.UserField.self)
    let id = try container.decode(String.self, forKey: .id)
    self.id = id
    let name = try container.decode(String.self, forKey: .name)
    self.name = name
    let userName = try container.decode(String.self, forKey: .username)
    self.userName = userName
    self.verified = try container.decodeIfPresent(Bool.self, forKey: .verified)
    self.description = try container.decodeIfPresent(String.self, forKey: .description)
    self.metrics = try container.decodeIfPresent(
      Sweet.UserPublicMetrics.self, forKey: .publicMetrics)
    self.protected = try container.decodeIfPresent(Bool.self, forKey: .protected)
    self.location = try container.decodeIfPresent(String.self, forKey: .location)
    self.pinnedTweetID = try container.decodeIfPresent(String.self, forKey: .pinnedTweetID)
    self.withheld = try container.decodeIfPresent(Sweet.WithheldModel.self, forKey: .withheld)
    self.entity = try container.decodeIfPresent(Sweet.UserEntityModel.self, forKey: .entities)

    let profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL)
    let removedNormalProfileImageURL: String? = profileImageURL?.replacingOccurrences(
      of: "_normal",
      with: ""
    )

    self.profileImageURL = removedNormalProfileImageURL.map { URL(string: $0) }!

    self.url = try container.decodeIfPresent(URL.self, forKey: .url)
    self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.UserField.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(userName, forKey: .username)
    try container.encodeIfPresent(verified, forKey: .verified)
    try container.encodeIfPresent(profileImageURL, forKey: .profileImageURL)
    try container.encodeIfPresent(createdAt, forKey: .createdAt)
    try container.encodeIfPresent(description, forKey: .description)
    try container.encodeIfPresent(protected, forKey: .protected)
    try container.encodeIfPresent(url, forKey: .url)
    try container.encodeIfPresent(location, forKey: .location)
    try container.encodeIfPresent(pinnedTweetID, forKey: .pinnedTweetID)
    try container.encodeIfPresent(metrics, forKey: .publicMetrics)
    try container.encodeIfPresent(withheld, forKey: .withheld)
    try container.encodeIfPresent(entity, forKey: .entities)
  }
}
