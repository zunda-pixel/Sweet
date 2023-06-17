//
//  URLModel.swift
//
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  /// URL Model
  public struct URLModel: Hashable, Sendable {
    public let start: Int
    public let end: Int
    public let url: URL
    public let expandedURL: String?
    public let displayURL: String?
    public let unwoundURL: String?
    public let images: [ImageModel]
    public let status: Int?
    public let title: String?
    public let description: String?

    public init(
      url: URL,
      start: Int,
      end: Int,
      expandedURL: String? = nil,
      displayURL: String? = nil,
      unwoundURL: String? = nil,
      images: [ImageModel] = [],
      status: Int? = nil,
      title: String? = nil,
      description: String? = nil
    ) {
      self.start = start
      self.end = end
      self.url = url
      self.expandedURL = expandedURL
      self.displayURL = displayURL
      self.unwoundURL = unwoundURL
      self.images = images
      self.status = status
      self.title = title
      self.description = description
    }
  }
}

extension Sweet.URLModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case start
    case end
    case url
    case expandedURL = "expanded_url"
    case displayURL = "display_url"
    case unwoundURL = "unwound_url"
    case images
    case status
    case title
    case description
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.start = try container.decode(Int.self, forKey: .start)
    self.end = try container.decode(Int.self, forKey: .end)

    self.url = try container.decode(URL.self, forKey: .url)

    self.expandedURL = try container.decodeIfPresent(String.self, forKey: .expandedURL)

    self.displayURL = try container.decodeIfPresent(String.self, forKey: .displayURL)

    self.unwoundURL = try container.decodeIfPresent(String.self, forKey: .unwoundURL)

    let images = try container.decodeIfPresent([Sweet.ImageModel].self, forKey: .images)
    self.images = images ?? []

    self.status = try container.decodeIfPresent(Int.self, forKey: .status)

    self.title = try container.decodeIfPresent(String.self, forKey: .title)
    self.description = try container.decodeIfPresent(String.self, forKey: .description)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(start, forKey: .start)
    try container.encode(end, forKey: .end)
    try container.encode(url, forKey: .url)
    try container.encode(expandedURL, forKey: .expandedURL)
    try container.encode(displayURL, forKey: .displayURL)
    try container.encodeIfPresent(unwoundURL, forKey: .unwoundURL)
    try container.encodeIfPresent(images, forKey: .images)
    try container.encodeIfPresent(status, forKey: .status)
    try container.encodeIfPresent(title, forKey: .title)
    try container.encodeIfPresent(description, forKey: .description)
  }
}
