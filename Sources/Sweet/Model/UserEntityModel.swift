//
//  EntityModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  /// User Entity Model
  public struct UserEntityModel: Hashable {
    public let urls: [URLModel]
    public let descriptionURLs: [URLModel]
    public let hashTags: [HashTagModel]
    public let mentions: [MentionModel]
    public let cashTags: [CashTagModel]

    public init(urls: [URLModel] = [], descriptionURLs: [URLModel], hashTags: [HashTagModel] = [],
                mentions: [MentionModel] = [], cashTags: [CashTagModel] = []) {
      self.urls = urls

      self.descriptionURLs = descriptionURLs
      self.hashTags = hashTags
      self.mentions = mentions
      self.cashTags = cashTags
    }
  }
}


extension Sweet.UserEntityModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case url
    case description
  }

  private enum URLCodingKeys: String, CodingKey {
    case urls
  }

  private enum DescriptionCodingKeys: String, CodingKey {
    case urls
    case hashTags = "hashtags"
    case mentions
    case cashTags = "cashtags"
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    let urlData = try? values.nestedContainer(keyedBy: URLCodingKeys.self, forKey: .url)

    let urls = try? urlData?.decode([Sweet.URLModel].self, forKey: .urls)

    self.urls = urls ?? []

    let descriptionData = try? values.nestedContainer(keyedBy: DescriptionCodingKeys.self, forKey: .description)

    let descriptionURLs = try? descriptionData?.decode([Sweet.URLModel].self, forKey: .urls)

    self.descriptionURLs = descriptionURLs ?? []

    let hashTags = try? descriptionData?.decode([Sweet.HashTagModel].self, forKey: .hashTags)
    self.hashTags = hashTags ?? []

    let mentions = try? descriptionData?.decode([Sweet.MentionModel].self, forKey: .mentions)
    self.mentions = mentions ?? []

    let cashTags = try? descriptionData?.decode([Sweet.CashTagModel].self, forKey: .cashTags)
    self.cashTags = cashTags ?? []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    var urlContainer = container.nestedContainer(keyedBy: URLCodingKeys.self, forKey: .url)
    try urlContainer.encode(urls, forKey: .urls)

    var descriptionContainer = container.nestedContainer(keyedBy: DescriptionCodingKeys.self, forKey: .description)
    try descriptionContainer.encode(descriptionURLs, forKey: .urls)
    try descriptionContainer.encode(hashTags, forKey: .hashTags)
    try descriptionContainer.encode(mentions, forKey: .mentions)
    try descriptionContainer.encode(cashTags, forKey: .cashTags)
  }
}
