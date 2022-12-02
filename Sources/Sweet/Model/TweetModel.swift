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
    let container = try decoder.container(keyedBy: Sweet.TweetField.self)

    self.id = try container.decode(String.self, forKey: .id)
    self.text = try container.decode(String.self, forKey: .text)

    self.authorID = try container.decodeIfPresent(String.self, forKey: .authorID)
    self.lang = try container.decodeIfPresent(String.self, forKey: .lang)

    let replySetting = try container.decodeIfPresent(String.self, forKey: .replySettings)
    self.replySetting = replySetting.map { Sweet.ReplySetting(rawValue: $0)! }

    self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
    self.source = try container.decodeIfPresent(String.self, forKey: .source)
    self.sensitive = try container.decodeIfPresent(Bool.self, forKey: .possiblySensitive)
    self.conversationID = try container.decodeIfPresent(String.self, forKey: .conversationID)
    self.replyUserID = try container.decodeIfPresent(String.self, forKey: .replyToUserID)
    self.geo = try container.decodeIfPresent(Sweet.SimpleGeoModel.self, forKey: .geo)

    self.publicMetrics = try container.decodeIfPresent(
      Sweet.TweetPublicMetrics.self,
      forKey: .publicMetrics
    )

    self.organicMetrics = try container.decodeIfPresent(
      Sweet.OrganicMetrics.self,
      forKey: .organicMetrics
    )

    self.privateMetrics = try container.decodeIfPresent(
      Sweet.PrivateMetrics.self,
      forKey: .privateMetrics
    )

    self.attachments = try container.decodeIfPresent(
      Sweet.AttachmentsModel.self, forKey: .attachments)

    self.promotedMetrics = try container.decodeIfPresent(
      Sweet.PromotedMetrics.self,
      forKey: .promotedMetrics
    )
    self.withheld = try container.decodeIfPresent(Sweet.WithheldModel.self, forKey: .withheld)

    let contextAnnotations = try container.decodeIfPresent(
      [Sweet.ContextAnnotationModel].self,
      forKey: .contextAnnotations
    )

    self.contextAnnotations = contextAnnotations ?? []

    self.entity = try container.decodeIfPresent(Sweet.TweetEntityModel.self, forKey: .entities)

    let referencedTweets = try container.decodeIfPresent(
      [Sweet.ReferencedTweetModel].self,
      forKey: .referencedTweets
    )

    self.referencedTweets = referencedTweets ?? []

    let editHistoryTweetIDs = try container.decodeIfPresent(
      [String].self, forKey: .editHistoryTweetIDs)
    self.editHistoryTweetIDs = editHistoryTweetIDs ?? []

    self.editControl = try container.decodeIfPresent(Sweet.EditControl.self, forKey: .editControls)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.TweetField.self)
    try container.encode(id, forKey: .id)
    try container.encode(text, forKey: .text)
    try container.encodeIfPresent(authorID, forKey: .authorID)
    try container.encodeIfPresent(lang, forKey: .lang)
    try container.encodeIfPresent(replySetting?.rawValue, forKey: .replySettings)
    try container.encodeIfPresent(createdAt, forKey: .createdAt)
    try container.encodeIfPresent(source, forKey: .source)
    try container.encodeIfPresent(sensitive, forKey: .possiblySensitive)
    try container.encodeIfPresent(conversationID, forKey: .conversationID)
    try container.encodeIfPresent(replyUserID, forKey: .replyToUserID)
    try container.encodeIfPresent(geo, forKey: .geo)
    try container.encodeIfPresent(publicMetrics, forKey: .publicMetrics)
    try container.encodeIfPresent(organicMetrics, forKey: .organicMetrics)
    try container.encodeIfPresent(privateMetrics, forKey: .privateMetrics)
    try container.encodeIfPresent(attachments, forKey: .attachments)
    try container.encodeIfPresent(promotedMetrics, forKey: .promotedMetrics)
    try container.encodeIfPresent(withheld, forKey: .withheld)
    try container.encodeIfPresent(contextAnnotations, forKey: .contextAnnotations)
    try container.encodeIfPresent(entity, forKey: .entities)
    try container.encodeIfPresent(referencedTweets, forKey: .referencedTweets)
    try container.encodeIfPresent(editHistoryTweetIDs, forKey: .editHistoryTweetIDs)
    try container.encodeIfPresent(editControl, forKey: .editControls)
  }
}
