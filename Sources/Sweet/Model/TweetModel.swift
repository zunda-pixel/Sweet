//
//  TweetModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation



public struct TweetModel {
  public let id: String
  public let text: String
  public let authorID: String?
  public let lang: String?
  public let replySettings: String?
  public let createdAt: Date?
  public let source: String?
  public let sensitive: Bool?
  public let geo: GeoModel?
  public let publicMetrics: TweetPublicMetricsModel?
  public let organicMetrics: OrganicMetricsModel?
  public let privateMetrics: PrivateMetricsModel?
  public let attachments: AttachmentsModel?
  public let promotedMerics: PromotedMetrics?
  public let withheld: WithheldModel?

  public var medias: [MediaModel] = []
  public var user: UserModel!
  public var place: PlaceModel?
  public var poll: PollModel?
}

extension TweetModel: Decodable {
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: TweetField.self)
    
    self.id = try value.decode(String.self, forKey: .id)
    self.text = try value.decode(String.self, forKey: .text)
    
    self.authorID = try? value.decode(String.self, forKey: .authorID)
    self.lang = try? value.decode(String.self, forKey: .lang)
    self.replySettings = try? value.decode(String.self, forKey: .replySettings)
    
    if let createdAt = try? value.decode(String.self, forKey: .createdAt) {
      let formatter = ISO8601DateFormatter()
      formatter.formatOptions.insert(.withFractionalSeconds)
      self.createdAt = formatter.date(from: createdAt)!
    } else {
      self.createdAt = nil
    }

    self.source = try? value.decode(String.self, forKey: .source)
    self.sensitive = try? value.decode(Bool.self, forKey: .possiblySensitive)
    
    self.geo = try? value.decode(GeoModel.self, forKey: .geo)
    
    self.publicMetrics = try? value.decode(TweetPublicMetricsModel.self, forKey: .publicMetrics)
    self.organicMetrics = try? value.decode(OrganicMetricsModel.self, forKey: .organicMetrics)
    self.privateMetrics = try? value.decode(PrivateMetricsModel.self, forKey: .privateMetrics)
    self.attachments = try? value.decode(AttachmentsModel.self, forKey: .attachments)
    self.promotedMerics = try? value.decode(PromotedMetrics.self, forKey: .promotedMetrics)
    self.withheld = try? value.decode(WithheldModel.self, forKey: .withheld)
  }
}
