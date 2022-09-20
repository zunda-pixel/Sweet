//
//  MediaVariant.swift
//  
//
//  Created by zunda on 2022/09/21.
//

import Foundation

extension Sweet {
  public struct MediaVariant: Hashable, Sendable {
    let bitRate: Int?
    let contentType: String
    let url: URL
  }
}

extension Sweet.MediaVariant: Codable {
  private enum CodingKeys: String, CodingKey {
    case bitRate = "bit_rate"
    case contentType = "content_type"
    case url
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    self.bitRate = try? value.decode(Int.self, forKey: .bitRate)
    self.contentType = try value.decode(String.self, forKey: .contentType)
    
    let urlString = try value.decode(String.self, forKey: .contentType)
    self.url = URL(string: urlString)!
  }
}
