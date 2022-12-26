//
//  MediaVariant.swift
//
//
//  Created by zunda on 2022/09/21.
//

import Foundation

extension Sweet {
  public struct MediaVariant: Hashable, Sendable {
    public let bitRate: Int?
    public let contentType: VideoType
    public let url: URL
  }
}

extension Sweet.MediaVariant: Codable {
  private enum CodingKeys: String, CodingKey {
    case bitRate = "bit_rate"
    case contentType = "content_type"
    case url
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(bitRate, forKey: .bitRate)
    try container.encode(contentType.rawValue, forKey: .contentType)
    try container.encode(url, forKey: .url)
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.bitRate = try container.decodeIfPresent(Int.self, forKey: .bitRate)
    let contentType = try container.decode(String.self, forKey: .contentType)
    self.contentType = Sweet.VideoType(rawValue: contentType)!

    self.url = try container.decode(URL.self, forKey: .url)
  }
}
