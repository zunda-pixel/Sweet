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
    if let bitRate { try container.encode(bitRate, forKey: .bitRate) }
    
    try container.encode(contentType.rawValue, forKey: .contentType)
    try container.encode(url, forKey: .url)
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    self.bitRate = try? value.decode(Int.self, forKey: .bitRate)
    let contentType = try value.decode(String.self, forKey: .contentType)
    self.contentType = .init(rawValue: contentType)!
    
    let urlString = try value.decode(String.self, forKey: .url)
    self.url = URL(string: urlString)!
  }
}
