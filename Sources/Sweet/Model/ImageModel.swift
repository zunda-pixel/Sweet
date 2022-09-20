//
//  ImageModel.swift
//  
//
//  Created by zunda on 2022/03/16.
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

import Foundation

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
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    let url = try values.decode(String.self, forKey: .url)
    self.url = .init(string: url)!
    
    let height = try values.decode(Int.self, forKey: .height)
    let width = try values.decode(Int.self, forKey: .width)
    
    self.size = .init(width: width, height: height)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(url, forKey: .url)
    try container.encode(size.height, forKey: .height)
    try container.encode(size.width, forKey: .width)
  }
}
