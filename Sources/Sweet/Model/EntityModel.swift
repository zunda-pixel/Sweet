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
  }
}

extension Sweet.EntityModel: Decodable {
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
}

extension Sweet.EntityModel {
  public struct HashtagModel {
    public let start: Int
    public let end: Int
    public let tag: String
  }
  
  public struct CashtagModel {
    public let start: Int
    public let end: Int
    public let tag: String
  }
  
  public struct MentionModel {
    public let start: Int
    public let end: Int
    public let userName: String
  }
}

extension Sweet.EntityModel.HashtagModel: Decodable {
  
}

extension Sweet.EntityModel.CashtagModel: Decodable {
  
}

extension Sweet.EntityModel.MentionModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case start
    case end
    case userName = "username"
  }
}
