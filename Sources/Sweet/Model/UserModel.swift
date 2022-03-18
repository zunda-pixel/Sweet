//
//  UserModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation



public struct UserModel {
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
  public let metrics: UserPublicMetricsModel?
  public var pinnedTweet: PinTweetModel?
  public var withheld: WithheldModel?
  public var entity: EntityModel?
}

extension UserModel: Decodable {
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: UserField.self)
    
    self.id = try values.decode(String.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name)
    self.userName = try values.decode(String.self, forKey: .username)
    self.verified = try? values.decode(Bool.self, forKey: .verified)
    self.description = try? values.decode(String.self, forKey: .description)
    self.metrics = try? values.decode(UserPublicMetricsModel.self, forKey: .publicMetrics)
    self.protected = try? values.decode(Bool.self, forKey: .protected)
    self.location = try? values.decode(String.self, forKey: .location)
    self.pinnedTweetID = try? values.decode(String.self, forKey: .pinnedTweetID)
    self.withheld = try? values.decode(WithheldModel.self, forKey: .withheld)
    self.entity = try? values.decode(EntityModel.self, forKey: .entities)
    
    let profileImageURL: String? = try? values.decode(String.self, forKey: .profileImageURL)
    self.profileImageURL = .init(string: profileImageURL ?? "")
    
    let url: String? = try? values.decode(String.self, forKey: .url)
    self.url = URL(string: url ?? "")
    
    let createdAt: String? = try? values.decode(String.self, forKey: .createdAt)
    self.createdAt = TwitterDateFormatter().date(from: createdAt ?? "")
  }
}
