//
//  SpaceModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct SpaceModel {
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
    //public var users: [UserModel]
  }
}

extension Sweet.SpaceModel: Decodable {
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: SpaceField.self)
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
    
    let invitedUserIDs = try? values.decode([String].self, forKey: .invited_userIDs)
    self.invitedUserIDs = invitedUserIDs ?? []
    
    let speakerIDs = try? values.decode([String].self, forKey: .speakeIDs)
    self.speakerIDs = speakerIDs ?? []
    
    self.subscriberCount = try? values.decode(Int.self, forKey: .subscriberCount)
    
    let topicIDs = try? values.decode([String].self, forKey: .topicIDs)
    self.topicIDs = topicIDs ?? []
  }
}
