//
//  EntityModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  public struct EntityModel {
    public let annotations: [AnnotationModel]
    public let urls: [URLModel]
    public let hashtags: [HashtagModel]
    public let mentions: [MentionModel]
    public let cashtags: [CashtagModel]
    
    public init(annotations: [AnnotationModel] = [], urls: [URLModel] = [], hashtags: [HashtagModel] = [],
                mentions: [MentionModel] = [], cashtags: [CashtagModel] = []) {
      self.annotations = annotations
      self.urls = urls
      self.hashtags = hashtags
      self.mentions = mentions
      self.cashtags = cashtags
    }
  }
}

extension Sweet.EntityModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case annotations
    case urls
    case hashtags
    case mentions
    case cashtags
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    let annotations = try? values.decode([AnnotationModel].self, forKey: .annotations)
    self.annotations = annotations ?? []
    
    let urls = try? values.decode([URLModel].self, forKey: .urls)
    self.urls = urls ?? []
    
    let hashtags = try? values.decode([HashtagModel].self, forKey: .hashtags)
    self.hashtags = hashtags ?? []
    
    let mentions = try? values.decode([MentionModel].self, forKey: .mentions)
    self.mentions = mentions ?? []
    
    let cashtags = try? values.decode([CashtagModel].self, forKey: .cashtags)
    self.cashtags = cashtags ?? []
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(annotations, forKey: .annotations)
    try container.encode(urls, forKey: .urls)
    try container.encode(hashtags, forKey: .hashtags)
    try container.encode(mentions, forKey: .mentions)
    try container.encode(cashtags, forKey: .cashtags)
  }
}

extension Sweet.EntityModel {
  public struct HashtagModel {
    public let start: Int
    public let end: Int
    public let tag: String
    
    public init(start: Int, end: Int, tag: String) {
      self.start = start
      self.end = end
      self.tag = tag
    }
  }
  
  public struct CashtagModel {
    public let start: Int
    public let end: Int
    public let tag: String
    
    public init(start: Int, end: Int, tag: String) {
      self.start = start
      self.end = end
      self.tag = tag
    }
  }
  
  public struct MentionModel {
    public let start: Int
    public let end: Int
    public let userName: String
    
    public init(start: Int, end: Int, userName: String) {
      self.start = start
      self.end = end
      self.userName = userName
    }
  }
}

extension Sweet.EntityModel.HashtagModel: Codable {
  
}

extension Sweet.EntityModel.CashtagModel: Codable {
  
}

extension Sweet.EntityModel.MentionModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case start
    case end
    case userName = "username"
  }
}

