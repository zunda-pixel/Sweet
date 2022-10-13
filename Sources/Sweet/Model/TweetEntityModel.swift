//
//  EntityModel.swift
//
//
//  Created by zunda on 2022/05/23.
//

import Foundation

extension Sweet {
  /// Tweet Entity Model
  public struct TweetEntityModel: Hashable, Sendable {
    public let annotations: [AnnotationModel]
    public let urls: [URLModel]
    public let hashtags: [HashTagModel]
    public let mentions: [MentionModel]
    public let cashtags: [CashTagModel]

    public init(
      annotations: [AnnotationModel] = [], urls: [URLModel] = [], hashtags: [HashTagModel] = [],
      mentions: [MentionModel] = [], cashtags: [CashTagModel] = []
    ) {
      self.annotations = annotations
      self.urls = urls
      self.hashtags = hashtags
      self.mentions = mentions
      self.cashtags = cashtags
    }
  }
}

extension Sweet.TweetEntityModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case annotations
    case urls
    case hashtags
    case mentions
    case cashtags
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    let annotations = try? values.decode([Sweet.AnnotationModel].self, forKey: .annotations)
    self.annotations = annotations ?? []

    let urls = try? values.decode([Sweet.URLModel].self, forKey: .urls)
    self.urls = urls ?? []

    let hashtags = try? values.decode([Sweet.HashTagModel].self, forKey: .hashtags)
    self.hashtags = hashtags ?? []

    let mentions = try? values.decode([Sweet.MentionModel].self, forKey: .mentions)
    self.mentions = mentions ?? []

    let cashtags = try? values.decode([Sweet.CashTagModel].self, forKey: .cashtags)
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

extension Sweet {
  public struct HashTagModel: Hashable, Sendable {
    public let start: Int
    public let end: Int
    public let tag: String

    public init(start: Int, end: Int, tag: String) {
      self.start = start
      self.end = end
      self.tag = tag
    }
  }

  public struct CashTagModel: Hashable, Sendable {
    public let start: Int
    public let end: Int
    public let tag: String

    public init(start: Int, end: Int, tag: String) {
      self.start = start
      self.end = end
      self.tag = tag
    }
  }

  public struct MentionModel: Hashable, Sendable {
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
