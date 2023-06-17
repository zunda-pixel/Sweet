//
//  ListModel.swift
//
//
//  Created by zunda on 2022/01/17.
//

import Foundation

#if canImport(CoreText)
  import CoreText
#endif

extension Sweet {
  /// List Model
  public struct ListModel: Hashable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let followerCount: Int?
    public let memberCount: Int?
    public let ownerID: String?
    public let description: String?
    public let isPrivate: Bool?
    public let createdAt: Date?

    public init(
      id: String,
      name: String,
      followerCount: Int? = nil,
      memberCount: Int? = nil,
      ownerID: String? = nil,
      description: String? = nil,
      isPrivate: Bool? = nil,
      createdAt: Date? = nil
    ) {
      self.id = id
      self.name = name
      self.followerCount = followerCount
      self.memberCount = memberCount
      self.ownerID = ownerID
      self.description = description
      self.isPrivate = isPrivate
      self.createdAt = createdAt
    }
  }
}

extension Sweet.ListModel: Codable {
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: Sweet.ListField.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.followerCount = try container.decodeIfPresent(Int.self, forKey: .followerCount)
    self.memberCount = try container.decodeIfPresent(Int.self, forKey: .memberCount)
    self.ownerID = try container.decodeIfPresent(String.self, forKey: .ownerID)
    self.description = try container.decodeIfPresent(String.self, forKey: .description)
    self.isPrivate = try container.decodeIfPresent(Bool.self, forKey: .isPrivate)

    self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.ListField.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encodeIfPresent(followerCount, forKey: .followerCount)
    try container.encodeIfPresent(memberCount, forKey: .memberCount)
    try container.encodeIfPresent(ownerID, forKey: .ownerID)
    try container.encodeIfPresent(description, forKey: .description)
    try container.encodeIfPresent(isPrivate, forKey: .isPrivate)
    try container.encodeIfPresent(createdAt, forKey: .createdAt)
  }
}
