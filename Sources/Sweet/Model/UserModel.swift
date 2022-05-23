//
//  UserModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation


extension Sweet {
  public struct UserModel: Hashable, Identifiable {
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
    
    public init(id: String, name: String, userName: String, verified: Bool? = nil, profileImageURL: URL? = nil,
                description: String? = nil, protected: Bool? = nil, url: URL? = nil, createdAt: Date? = nil,
                location: String? = nil, pinnedTweetID: String? = nil, metrics: UserPublicMetrics? = nil,
                withheld: WithheldModel? = nil, entity: UserEntityModel? = nil) {
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
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: Sweet.UserField.self)
    
    self.id = try values.decode(String.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name)
    self.userName = try values.decode(String.self, forKey: .username)
    self.verified = try? values.decode(Bool.self, forKey: .verified)
    self.description = try? values.decode(String.self, forKey: .description)
    self.metrics = try? values.decode(Sweet.UserPublicMetrics.self, forKey: .publicMetrics)
    self.protected = try? values.decode(Bool.self, forKey: .protected)
    self.location = try? values.decode(String.self, forKey: .location)
    self.pinnedTweetID = try? values.decode(String.self, forKey: .pinnedTweetID)
    self.withheld = try? values.decode(Sweet.WithheldModel.self, forKey: .withheld)
    self.entity = try? values.decode(Sweet.UserEntityModel.self, forKey: .entities)
    
    let profileImageURL: String? = try? values.decode(String.self, forKey: .profileImageURL)
    self.profileImageURL = .init(string: profileImageURL ?? "")
    
    let url: String? = try? values.decode(String.self, forKey: .url)
    self.url = URL(string: url ?? "")
    
    if let createdAt = try? values.decode(String.self, forKey: .createdAt) {
      self.createdAt = Sweet.TwitterDateFormatter().date(from: createdAt)!
    } else {
      self.createdAt = nil
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.UserField.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(userName, forKey: .username)
    try container.encode(verified, forKey: .verified)
    try container.encode(profileImageURL, forKey: .profileImageURL)

    if let createdAt = createdAt {
      let createdAtString = Sweet.TwitterDateFormatter().string(from: createdAt)
      try container.encode(createdAtString, forKey: .createdAt)
    }

    try container.encode(description, forKey: .description)
    try container.encode(protected, forKey: .protected)
    try container.encode(url, forKey: .url)
    try container.encode(location, forKey: .location)
    try container.encode(pinnedTweetID, forKey: .pinnedTweetID)
    try container.encode(metrics, forKey: .publicMetrics)
    try container.encode(withheld, forKey: .withheld)
    try container.encode(entity, forKey: .entities)
  }
}
