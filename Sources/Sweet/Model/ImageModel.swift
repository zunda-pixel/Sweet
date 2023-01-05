//
//  ImageModel.swift
//
//
//  Created by zunda on 2022/03/16.
//

import Foundation

#if canImport(CoreGraphics)
  import CoreGraphics
#endif

extension Sweet {
  /// Image Model
  public struct ImageModel: Hashable, Sendable {
    public let url: URL
    public let size: CGSize

    public init(url: URL, size: CGSize) {
      self.url = url
      self.size = size
    }
  }
}

extension Sweet.ImageModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case url
    case width
    case height
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.url = try container.decode(URL.self, forKey: .url)

    let height = try container.decode(Int.self, forKey: .height)
    let width = try container.decode(Int.self, forKey: .width)

    self.size = CGSize(width: width, height: height)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(url, forKey: .url)
    try container.encode(size.height, forKey: .height)
    try container.encode(size.width, forKey: .width)
  }
}
