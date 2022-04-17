//
//  MediaModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

#if !os(macOS)
import CoreGraphics
#endif

import Foundation

extension Sweet {
  public struct MediaModel: Hashable, Identifiable {
    public var id: String { key }
    public let key: String
    public let type: MediaType
    public let size: CGSize
    public let previewImageURL: URL?
    public let url: URL?
    
    public init(key: String, type: MediaType, size: CGSize, previewImageURL: URL? = nil, url: URL? = nil) {
      self.key = key
      self.type = type
      self.size = size
      self.previewImageURL = previewImageURL
      self.url = url
    }
  }
}

extension Sweet.MediaModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case key = "media_key"
    case type
    case width
    case height
    case previewImageURL = "preview_image_url"
    case url
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    let type = try value.decode(String.self, forKey: .type)
    self.type = .init(rawValue: type)!
    
    self.key = try value.decode(String.self, forKey: .key)
    
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
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type.rawValue, forKey: .type)
    try container.encode(key, forKey: .key)
    try container.encode(size.width, forKey: .width)
    try container.encode(size.height, forKey: .height)
    try container.encode(previewImageURL, forKey: .previewImageURL)
    try container.encode(url, forKey: .url)
  }
}
