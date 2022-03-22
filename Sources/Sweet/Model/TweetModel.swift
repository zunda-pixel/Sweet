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
    public let publicMetrics: TweetPublicMetricsModel?
    public let organicMetrics: OrganicMetricsModel?
    public let privateMetrics: PrivateMetricsModel?
    public let attachments: AttachmentsModel?
    public let promotedMerics: PromotedMetrics?
    public let withheld: WithheldModel?
    public let contextAnnotations: [ContextAnnotationModel]
    public let entity: EntityModel?
    public let referencedTweet: ReferencedTweetModel?
    
    public var medias: [MediaModel] = []
    public var user: UserModel?
    public var place: PlaceModel?
    public var poll: PollModel?
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
      self.createdAt = TwitterDateFormatter().date(from: createdAt)!
    } else {
      self.createdAt = nil
    }

    self.source = try? value.decode(String.self, forKey: .source)
    self.sensitive = try? value.decode(Bool.self, forKey: .possiblySensitive)
    self.conversationID = try? value.decode(String.self, forKey: .conversationID)
    self.replyUserID = try? value.decode(String.self, forKey: .inReplyToUserID)
    self.geo = try? value.decode(Sweet.GeoModel.self, forKey: .geo)
    
    self.publicMetrics = try? value.decode(TweetPublicMetricsModel.self, forKey: .publicMetrics)
    self.organicMetrics = try? value.decode(OrganicMetricsModel.self, forKey: .organicMetrics)
    self.privateMetrics = try? value.decode(PrivateMetricsModel.self, forKey: .privateMetrics)
    self.attachments = try? value.decode(Sweet.AttachmentsModel.self, forKey: .attachments)
    self.promotedMerics = try? value.decode(PromotedMetrics.self, forKey: .promotedMetrics)
    self.withheld = try? value.decode(Sweet.WithheldModel.self, forKey: .withheld)
    
    let contextAnnotations = try? value.decode([Sweet.ContextAnnotationModel].self, forKey: .contextAnnotations)
    self.contextAnnotations = contextAnnotations ?? []
    
    self.entity = try? value.decode(Sweet.EntityModel.self, forKey: .entities)
    
    let referencedTweets = try? value.decode([Sweet.ReferencedTweetModel].self, forKey: .referencedTweets)
    self.referencedTweet = referencedTweets?.first
  }
}
