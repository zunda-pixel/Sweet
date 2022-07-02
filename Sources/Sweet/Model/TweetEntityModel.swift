//
//  EntityModel.swift
//  
//
//  Created by zunda on 2022/05/23.
//

import Foundation

extension Sweet {
  /// Tweet Entity Model
  public struct TweetEntityModel: Hashable {
    public let annotations: [AnnotationModel]
    public let urls: [URLModel]
    public let hashTags: [HashTagModel]
    public let mentions: [MentionModel]
    public let cashTags: [CashTagModel]

    public init(annotations: [AnnotationModel] = [], urls: [URLModel] = [], hashTags: [HashTagModel] = [],
                mentions: [MentionModel] = [], cashTags: [CashTagModel] = []) {
      self.annotations = annotations
      self.urls = urls
      self.hashTags = hashTags
      self.mentions = mentions
      self.cashTags = cashTags
    }
  }
}

extension Sweet.TweetEntityModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case annotations
    case urls
    case hashTags
    case mentions
    case cashTags
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    let annotations = try? values.decode([Sweet.AnnotationModel].self, forKey: .annotations)
    self.annotations = annotations ?? []

    let urls = try? values.decode([Sweet.URLModel].self, forKey: .urls)
    self.urls = urls ?? []

    let hashTags = try? values.decode([Sweet.HashTagModel].self, forKey: .hashTags)
    self.hashTags = hashTags ?? []

    let mentions = try? values.decode([Sweet.MentionModel].self, forKey: .mentions)
    self.mentions = mentions ?? []

    let cashTags = try? values.decode([Sweet.CashTagModel].self, forKey: .cashTags)
    self.cashTags = cashTags ?? []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(annotations, forKey: .annotations)
    try container.encode(urls, forKey: .urls)
    try container.encode(hashTags, forKey: .hashTags)
    try container.encode(mentions, forKey: .mentions)
    try container.encode(cashTags, forKey: .cashTags)
  }
}

extension Sweet {
  public struct HashTagModel: Hashable {
    public let start: Int
    public let end: Int
    public let tag: String

    public init(start: Int, end: Int, tag: String) {
      self.start = start
      self.end = end
      self.tag = tag
    }
  }

  public struct CashTagModel: Hashable {
    public let start: Int
    public let end: Int
    public let tag: String

    public init(start: Int, end: Int, tag: String) {
      self.start = start
      self.end = end
      self.tag = tag
    }
  }

  public struct MentionModel: Hashable {
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

extension Sweet.HashTagModel: Codable {

}

extension Sweet.CashTagModel: Codable {

}

extension Sweet.MentionModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case start
    case end
    case userName = "username"
  }
}
