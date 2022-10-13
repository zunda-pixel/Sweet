//
//  TweetModel.swift
//
//
//  Created by zunda on 2022/01/14.
//

import Foundation

extension Sweet {
  /// Tweet Model
  public struct TweetModel: Hashable, Identifiable, Sendable {
    public let id: String
    public let text: String
    public let authorID: String?
    public let lang: String?
    public let replySetting: ReplySetting?
    public let createdAt: Date?
    public let source: String?
    public let sensitive: Bool?
    public let conversationID: String?
    public let replyUserID: String?
    public let geo: SimpleGeoModel?
    public let publicMetrics: TweetPublicMetrics?
    public let privateMetrics: PrivateMetrics?
    public let promotedMetrics: PromotedMetrics?
    public let organicMetrics: OrganicMetrics?
    public let attachments: AttachmentsModel?
    public let withheld: WithheldModel?
    public let contextAnnotations: [ContextAnnotationModel]
    public let entity: TweetEntityModel?
    public let referencedTweets: [ReferencedTweetModel]
    public let editHistoryTweetIDs: [String]
    public let editControl: EditControl?

    public init(
      id: String, text: String, authorID: String? = nil, lang: String? = nil,
      replySetting: ReplySetting? = nil,
      createdAt: Date? = nil, source: String? = nil, sensitive: Bool? = nil,
      conversationID: String? = nil,
      replyUserID: String? = nil, geo: SimpleGeoModel? = nil,
      publicMetrics: TweetPublicMetrics? = nil,
      organicMetrics: OrganicMetrics? = nil, privateMetrics: PrivateMetrics? = nil,
      attachments: AttachmentsModel? = nil, promotedMetrics: PromotedMetrics? = nil,
      withheld: WithheldModel? = nil, contextAnnotations: [ContextAnnotationModel] = [],
      entity: TweetEntityModel? = nil, referencedTweets: [ReferencedTweetModel] = [],
      editHistoryTweetIDs: [String] = [], editControl: EditControl? = nil
    ) {
      self.id = id
      self.text = text
      self.authorID = authorID
      self.lang = lang
      self.replySetting = replySetting
      self.createdAt = createdAt
      self.source = source
      self.sensitive = sensitive
      self.conversationID = conversationID
      self.replyUserID = replyUserID
      self.geo = geo
      self.publicMetrics = publicMetrics
      self.privateMetrics = privateMetrics
      self.promotedMetrics = promotedMetrics
      self.organicMetrics = organicMetrics
      self.attachments = attachments
      self.withheld = withheld
      self.contextAnnotations = contextAnnotations
      self.entity = entity
      self.referencedTweets = referencedTweets
      self.editHistoryTweetIDs = editHistoryTweetIDs
      self.editControl = editControl
    }
  }
}

extension Sweet.TweetModel: Codable {
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: Sweet.TweetField.self)

    self.id = try value.decode(String.self, forKey: .id)
    self.text = try value.decode(String.self, forKey: .text)

    self.authorID = try? value.decode(String.self, forKey: .authorID)
    self.lang = try? value.decode(String.self, forKey: .lang)

    let replySetting = try? value.decode(String.self, forKey: .replySettings)
    self.replySetting = .init(rawValue: replySetting ?? "")

    if let createdAt = try? value.decode(String.self, forKey: .createdAt) {
      self.createdAt = Sweet.TwitterDateFormatter().date(from: createdAt)!
    } else {
      self.createdAt = nil
    }

    self.source = try? value.decode(String.self, forKey: .source)
    self.sensitive = try? value.decode(Bool.self, forKey: .possiblySensitive)
    self.conversationID = try? value.decode(String.self, forKey: .conversationID)
    self.replyUserID = try? value.decode(String.self, forKey: .replyToUserID)
    self.geo = try? value.decode(Sweet.SimpleGeoModel.self, forKey: .geo)

    self.publicMetrics = try? value.decode(Sweet.TweetPublicMetrics.self, forKey: .publicMetrics)
    self.organicMetrics = try? value.decode(Sweet.OrganicMetrics.self, forKey: .organicMetrics)
    self.privateMetrics = try? value.decode(Sweet.PrivateMetrics.self, forKey: .privateMetrics)
    self.attachments = try? value.decode(Sweet.AttachmentsModel.self, forKey: .attachments)
    self.promotedMetrics = try? value.decode(Sweet.PromotedMetrics.self, forKey: .promotedMetrics)
    self.withheld = try? value.decode(Sweet.WithheldModel.self, forKey: .withheld)

    let contextAnnotations = try? value.decode(
      [Sweet.ContextAnnotationModel].self, forKey: .contextAnnotations)
    self.contextAnnotations = contextAnnotations ?? []

    self.entity = try? value.decode(Sweet.TweetEntityModel.self, forKey: .entities)

    let referencedTweets = try? value.decode(
      [Sweet.ReferencedTweetModel].self, forKey: .referencedTweets)
    self.referencedTweets = referencedTweets ?? []

    let editHistoryTweetIDs = try? value.decode([String].self, forKey: .editHistoryTweetIDs)
    self.editHistoryTweetIDs = editHistoryTweetIDs ?? []

    self.editControl = try? value.decode(Sweet.EditControl.self, forKey: .editControls)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.TweetField.self)
    try container.encode(id, forKey: .id)
    try container.encode(text, forKey: .text)
    try container.encode(authorID, forKey: .authorID)
    try container.encode(lang, forKey: .lang)
    try container.encode(replySetting?.rawValue, forKey: .replySettings)

    if let createdAt {
      let createdAtString = Sweet.TwitterDateFormatter().string(from: createdAt)
      try container.encode(createdAtString, forKey: .createdAt)
    }

    try container.encode(source, forKey: .source)
    try container.encode(sensitive, forKey: .possiblySensitive)
    try container.encode(conversationID, forKey: .conversationID)
    try container.encode(replyUserID, forKey: .replyToUserID)
    try container.encode(geo, forKey: .geo)
    try container.encode(publicMetrics, forKey: .publicMetrics)
    try container.encode(organicMetrics, forKey: .organicMetrics)
    try container.encode(privateMetrics, forKey: .privateMetrics)
    try container.encode(attachments, forKey: .attachments)
    try container.encode(promotedMetrics, forKey: .promotedMetrics)
    try container.encode(withheld, forKey: .withheld)
    try container.encode(contextAnnotations, forKey: .contextAnnotations)
    try container.encode(entity, forKey: .entities)
    try container.encode(referencedTweets, forKey: .referencedTweets)
    try container.encode(editHistoryTweetIDs, forKey: .editHistoryTweetIDs)
    try container.encode(editControl, forKey: .editControls)
  }
}
