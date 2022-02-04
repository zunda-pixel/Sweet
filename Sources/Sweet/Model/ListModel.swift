//
//  ListModel.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

public struct SendListModel: Codable {
  public let name: String?
  public let description: String?
  public let isPrivate: Bool?
  
  private enum CodingKeys: String, CodingKey {
    case name
    case description
    case isPrivate = "private"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if let name = name {
      try container.encode(name, forKey: .name)
    }
    if let description = description {
      try container.encode(description, forKey: .description)
    }
    if let isPrivate = isPrivate  {
      try container.encode(isPrivate, forKey: .isPrivate)
    }
  }
}

public struct ListModel: Decodable {
  public let id: String
  public let name: String
  public let followerCount: Int?
  public let memberCount: Int?
  public let ownerID: String?
  public let description: String?
  public let isPrivate: Bool?
  public let createdAt: Date?
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: ListField.self)
    self.id = try values.decode(String.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name)
    self.followerCount = try? values.decode(Int.self, forKey: .followerCount)
    self.memberCount = try? values.decode(Int.self, forKey: .memberCount)
    self.ownerID = try? values.decode(String.self, forKey: .ownerID)
    self.description = try? values.decode(String.self, forKey: .description)
    self.isPrivate = try? values.decode(Bool.self, forKey: .isPrivate)
    
    let createdAt = try? values.decode(String.self, forKey: .createdAt)
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    self.createdAt = formatter.date(from: createdAt ?? "")
  }
}

public struct ListResponseModel: Decodable {
  public let list: ListModel

	private enum CodingKeys: String, CodingKey {
		case list = "data"
  }
}

struct ListsResponseModel: Decodable {
  public let lists: [ListModel]

	private enum CodingKeys: String, CodingKey {
		case lists = "data"
  }
}

struct MemberResponseModel: Decodable {
  public let isMember: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case isMember = "is_member"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.isMember = try usersInfo.decode(Bool.self, forKey: .isMember)
  }
}

public struct PinResponseModel: Decodable {
  public let pinned: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case pinned
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.pinned = try usersInfo.decode(Bool.self, forKey: .pinned)
  }
}

public struct UpdateResponseModel: Decodable {
  public let updated: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case updated
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.updated = try usersInfo.decode(Bool.self, forKey: .updated)
  }
}
