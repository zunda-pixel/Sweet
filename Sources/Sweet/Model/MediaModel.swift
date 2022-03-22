//
//  MediaModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct MediaModel {
    public let key: String
    public let type: MediaType
    public let width: Int
    public let height: Int
    public let previewImageURL: URL?
    public let url: URL?
  }
}

extension Sweet.MediaModel: Decodable {
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
    self.height = try value.decode(Int.self, forKey: .height)
    self.width = try value.decode(Int.self, forKey: .width)
    
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
}
