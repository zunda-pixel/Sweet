//
//  TweetModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation


extension Sweet {
  public struct TweetModel {
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
    public let geo: GeoModel?
    public let publicMetrics: TweetPublicMetrics?
    public let privateMetrics: PrivateMetrics?
    public let promotedMerics: PromotedMetrics?
    public let organicMetrics: OrganicMetrics?
    public let attachments: AttachmentsModel?
    public let withheld: WithheldModel?
    public let contextAnnotations: [ContextAnnotationModel]
    public let entity: EntityModel?
    public let referencedTweet: ReferencedTweetModel?
    
    public init(id: String, text: String, authorID: String? = nil, lang: String? = nil, replySetting: ReplySetting? = nil,
                createdAt: Date? = nil, source: String? = nil, sensitive: Bool? = nil, conversationID: String? = nil,
                replyUserID: String? = nil, geo: GeoModel? = nil, publicMetrics: TweetPublicMetrics? = nil,
                organicMetrics: OrganicMetrics? = nil, privateMetrics: PrivateMetrics? = nil,
                attachments: AttachmentsModel? = nil, promotedMetrics: PromotedMetrics? = nil,
                withheld: WithheldModel? = nil, contextAnnotations: [ContextAnnotationModel] = [],
                entity: EntityModel? = nil, referencedTweet: ReferencedTweetModel? = nil) {
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
      self.promotedMerics = promotedMetrics
      self.organicMetrics = organicMetrics
      self.attachments = attachments
      self.withheld = withheld
      self.contextAnnotations = contextAnnotations
      self.entity = entity
      self.referencedTweet = referencedTweet
    }
  }
}

extension Sweet.TweetModel: Decodable {
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: TweetField.self)
    
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
    self.replyUserID = try? value.decode(String.self, forKey: .inReplyToUserID)
    self.geo = try? value.decode(Sweet.GeoModel.self, forKey: .geo)
    
    self.publicMetrics = try? value.decode(Sweet.TweetPublicMetrics.self, forKey: .publicMetrics)
    self.organicMetrics = try? value.decode(Sweet.OrganicMetrics.self, forKey: .organicMetrics)
    self.privateMetrics = try? value.decode(Sweet.PrivateMetrics.self, forKey: .privateMetrics)
    self.attachments = try? value.decode(Sweet.AttachmentsModel.self, forKey: .attachments)
    self.promotedMerics = try? value.decode(Sweet.PromotedMetrics.self, forKey: .promotedMetrics)
    self.withheld = try? value.decode(Sweet.WithheldModel.self, forKey: .withheld)
    
    let contextAnnotations = try? value.decode([Sweet.ContextAnnotationModel].self, forKey: .contextAnnotations)
    self.contextAnnotations = contextAnnotations ?? []
    
    self.entity = try? value.decode(Sweet.EntityModel.self, forKey: .entities)
    
    let referencedTweets = try? value.decode([Sweet.ReferencedTweetModel].self, forKey: .referencedTweets)
    self.referencedTweet = referencedTweets?.first
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: TweetField.self)
    try container.encode(id, forKey: .id)
    try container.encode(text, forKey: .text)
    try container.encode(authorID, forKey: .authorID)
    try container.encode(lang, forKey: .lang)
    try container.encode(replySetting?.rawValue, forKey: .replySettings)
    try container.encode(createdAt, forKey: .createdAt)
    try container.encode(source, forKey: .source)
    try container.encode(sensitive, forKey: .possiblySensitive)
    try container.encode(conversationID, forKey: .conversationID)
    try container.encode(replyUserID, forKey: .inReplyToUserID)
    try container.encode(geo, forKey: .geo)
    try container.encode(publicMetrics, forKey: .publicMetrics)
    try container.encode(organicMetrics, forKey: .organicMetrics)
    try container.encode(privateMetrics, forKey: .privateMetrics)
    try container.encode(attachments, forKey: .attachments)
    try container.encode(promotedMerics, forKey: .promotedMetrics)
    try container.encode(withheld, forKey: .withheld)
    try container.encode(contextAnnotations, forKey: .contextAnnotations)
    try container.encode(entity, forKey: .entities)
    try container.encode(referencedTweet, forKey: .referencedTweets)
  }
}
