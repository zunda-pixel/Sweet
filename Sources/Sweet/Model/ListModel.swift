//
//  ListModel.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation

public struct ListModel {
  public let id: String
  public let name: String
  public let followerCount: Int?
  public let memberCount: Int?
  public let ownerID: String?
  public let description: String?
  public let isPrivate: Bool?
  public let createdAt: Date?
  public var users: [UserModel]
}

extension ListModel: Decodable {
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
    self.createdAt = TwitterDateFormatter().date(from: createdAt ?? "")
    self.users = []
  }
}
