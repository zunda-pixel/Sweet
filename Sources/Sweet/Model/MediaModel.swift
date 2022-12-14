//
//  MediaModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

#if canImport(CoreGraphics)
  import CoreGraphics
#endif

extension Sweet {
  /// Media Model
  public struct MediaModel: Hashable, Identifiable, Sendable {
    public var id: String { key }
    public let key: String
    public let type: MediaType
    public let size: CGSize?
    public let previewImageURL: URL?
    public let url: URL?
    public let variants: [MediaVariant]
    public let durationMicroSeconds: Int?
    public let alternateText: String?
    public let metrics: MediaPublicMetrics?
    public let privateMetrics: MediaPrivateMetrics?
    public let promotedMetrics: MediaPromotedMetrics?
    public let organicMetrics: MediaOrganicMetrics?

    public init(
      key: String, type: MediaType, size: CGSize?, previewImageURL: URL? = nil, url: URL? = nil,
      variants: [MediaVariant] = [], durationMicroSeconds: Int? = nil, alternateText: String? = nil,
      metrics: MediaPublicMetrics? = nil, privateMetrics: MediaPrivateMetrics? = nil,
      promotedMetrics: MediaPromotedMetrics? = nil, organicMetrics: MediaOrganicMetrics? = nil
    ) {
      self.key = key
      self.type = type
      self.size = size
      self.previewImageURL = previewImageURL
      self.url = url
      self.variants = variants
      self.durationMicroSeconds = durationMicroSeconds
      self.alternateText = alternateText
      self.metrics = metrics
      self.privateMetrics = privateMetrics
      self.promotedMetrics = promotedMetrics
      self.organicMetrics = organicMetrics
    }
  }
}

extension Sweet.MediaModel: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Sweet.MediaField.self)

    let type = try container.decode(String.self, forKey: .type)
    self.type = .init(rawValue: type)!

    self.key = try container.decode(String.self, forKey: .mediaKey)

    let height = try container.decodeIfPresent(Int.self, forKey: .height)
    let width = try container.decodeIfPresent(Int.self, forKey: .width)

    if let height, let width {
      self.size = CGSize(width: width, height: height)
    } else {
      self.size = nil
    }

    let previewImageURL = try container.decodeIfPresent(String.self, forKey: .previewImageURL)
    self.previewImageURL = previewImageURL.map { URL(string: $0)! }

    let url = try container.decodeIfPresent(String.self, forKey: .url)
    self.url = url.map { URL(string: $0)! }

    let variants = try container.decodeIfPresent([Sweet.MediaVariant].self, forKey: .variants)
    self.variants = variants ?? []

    self.durationMicroSeconds = try container.decodeIfPresent(
      Int.self, forKey: .durationMicroSeconds)

    self.alternateText = try container.decodeIfPresent(String.self, forKey: .alternateText)

    self.metrics = try container.decodeIfPresent(
      Sweet.MediaPublicMetrics.self, forKey: .publicMetrics)

    self.privateMetrics = try container.decodeIfPresent(
      Sweet.MediaPrivateMetrics.self,
      forKey: .privateMetrics
    )

    self.promotedMetrics = try container.decodeIfPresent(
      Sweet.MediaPromotedMetrics.self,
      forKey: .promotedMetrics
    )

    self.organicMetrics = try container.decodeIfPresent(
      Sweet.MediaOrganicMetrics.self,
      forKey: .organicMetrics
    )
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.MediaField.self)
    try container.encode(type.rawValue, forKey: .type)
    try container.encode(key, forKey: .mediaKey)
    try container.encodeIfPresent(size?.width, forKey: .width)
    try container.encodeIfPresent(size?.height, forKey: .height)
    try container.encodeIfPresent(previewImageURL, forKey: .previewImageURL)
    try container.encodeIfPresent(url, forKey: .url)
    try container.encodeIfPresent(variants, forKey: .variants)
    try container.encodeIfPresent(durationMicroSeconds, forKey: .durationMicroSeconds)
    try container.encodeIfPresent(alternateText, forKey: .alternateText)
    try container.encodeIfPresent(metrics, forKey: .publicMetrics)
    try container.encodeIfPresent(privateMetrics, forKey: .privateMetrics)
    try container.encodeIfPresent(promotedMetrics, forKey: .promotedMetrics)
    try container.encodeIfPresent(organicMetrics, forKey: .organicMetrics)
  }
}
