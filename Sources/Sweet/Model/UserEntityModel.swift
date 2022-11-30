//
//  UserEntityModel.swift
//

import Foundation

extension Sweet {
  /// User Entity Model
  public struct UserEntityModel: Hashable, Sendable {
    public let urls: [URLModel]
    public let descriptionURLs: [URLModel]
    public let hashTags: [HashTagModel]
    public let mentions: [MentionModel]
    public let cashTags: [CashTagModel]

    public init(
      urls: [URLModel] = [],
      descriptionURLs: [URLModel],
      hashTags: [HashTagModel] = [],
      mentions: [MentionModel] = [],
      cashTags: [CashTagModel] = []
    ) {
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
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let urlData = try? container.nestedContainer(keyedBy: URLCodingKeys.self, forKey: .url)

    let urls = try urlData?.decodeIfPresent([Sweet.URLModel].self, forKey: .urls)

    self.urls = urls ?? []

    let descriptionContainer = try? container.nestedContainer(
      keyedBy: DescriptionCodingKeys.self,
      forKey: .description
    )

    let descriptionURLs = try descriptionContainer?.decodeIfPresent(
      [Sweet.URLModel].self, forKey: .urls)

    self.descriptionURLs = descriptionURLs ?? []

    let hashTags = try descriptionContainer?.decodeIfPresent(
      [Sweet.HashTagModel].self,
      forKey: .hashTags
    )

    self.hashTags = hashTags ?? []

    let mentions = try descriptionContainer?.decodeIfPresent(
      [Sweet.MentionModel].self,
      forKey: .mentions
    )

    self.mentions = mentions ?? []

    let cashTags = try descriptionContainer?.decodeIfPresent(
      [Sweet.CashTagModel].self,
      forKey: .cashTags
    )

    self.cashTags = cashTags ?? []
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    var urlContainer = container.nestedContainer(keyedBy: URLCodingKeys.self, forKey: .url)
    try urlContainer.encode(urls, forKey: .urls)

    var descriptionContainer = container.nestedContainer(
      keyedBy: DescriptionCodingKeys.self, forKey: .description)
    try descriptionContainer.encode(descriptionURLs, forKey: .urls)
    try descriptionContainer.encode(hashTags, forKey: .hashTags)
    try descriptionContainer.encode(mentions, forKey: .mentions)
    try descriptionContainer.encode(cashTags, forKey: .cashTags)
  }
}
