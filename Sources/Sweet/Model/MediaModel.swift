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
    public let size: CGSize
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
      key: String, type: MediaType, size: CGSize, previewImageURL: URL? = nil, url: URL? = nil,
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
    let value = try decoder.container(keyedBy: Sweet.MediaField.self)

    let type = try value.decode(String.self, forKey: .type)
    self.type = .init(rawValue: type)!

    self.key = try value.decode(String.self, forKey: .mediaKey)

    let height = try value.decode(Int.self, forKey: .height)
    let width = try value.decode(Int.self, forKey: .width)
    self.size = .init(width: width, height: height)

    if let previewImageURL = try? value.decode(String.self, forKey: .previewImageURL) {
      self.previewImageURL = .init(string: previewImageURL)
    } else {
      self.previewImageURL = nil
    }

    if let url = try? value.decode(String.self, forKey: .url) {
      self.url = .init(string: url)
    } else {
      self.url = nil
    }

    if let variants = try? value.decode([Sweet.MediaVariant].self, forKey: .variants) {
      self.variants = variants
    } else {
      self.variants = []
    }

    self.durationMicroSeconds = try? value.decode(Int.self, forKey: .durationMicroSeconds)
    self.alternateText = try? value.decode(String.self, forKey: .alternateText)

    self.metrics = try? value.decode(Sweet.MediaPublicMetrics.self, forKey: .publicMetrics)
    self.privateMetrics = try? value.decode(Sweet.MediaPrivateMetrics.self, forKey: .privateMetrics)
    self.promotedMetrics = try? value.decode(
      Sweet.MediaPromotedMetrics.self, forKey: .promotedMetrics)
    self.organicMetrics = try? value.decode(Sweet.MediaOrganicMetrics.self, forKey: .organicMetrics)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Sweet.MediaField.self)
    try container.encode(type.rawValue, forKey: .type)
    try container.encode(key, forKey: .mediaKey)
    try container.encode(size.width, forKey: .width)
    try container.encode(size.height, forKey: .height)
    try container.encode(previewImageURL, forKey: .previewImageURL)
    try container.encode(url, forKey: .url)
    try container.encode(variants, forKey: .variants)
    try container.encode(durationMicroSeconds, forKey: .durationMicroSeconds)
    try container.encode(alternateText, forKey: .alternateText)
    try container.encode(metrics, forKey: .publicMetrics)
    try container.encode(privateMetrics, forKey: .privateMetrics)
    try container.encode(promotedMetrics, forKey: .promotedMetrics)
    try container.encode(organicMetrics, forKey: .organicMetrics)
  }
}
