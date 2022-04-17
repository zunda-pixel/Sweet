//
//  EntityURLModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet.EntityModel {
  public struct URLModel: Hashable {
    public let start: Int
    public let end: Int
    public let url: URL
    public let expandedURL: URL
    public let displayURL: String
    public let unwoundURL: URL
    public let images: [ImageModel]
    public let status: Int?
    public let title: String?
    public let description: String?
    
    public init(start: Int, end: Int, url: URL, expandedURL: URL, displayURL: String, unwoundURL: URL,
                images: [ImageModel] = [], status: Int? = nil, title: String? = nil, description: String? = nil) {
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

extension Sweet.EntityModel.URLModel: Codable {
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
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    self.start = try values.decode(Int.self, forKey: .start)
    self.end = try values.decode(Int.self, forKey: .end)
    
    let url = try values.decode(String.self, forKey: .url)
    self.url = .init(string: url)!
    
    let expandedURL = try values.decode(String.self, forKey: .expandedURL)
    self.expandedURL = .init(string: expandedURL)!
    
    self.displayURL = try values.decode(String.self, forKey: .displayURL)
    
    let unwoundURL = try values.decode(String.self, forKey: .unwoundURL)
    self.unwoundURL = .init(string: unwoundURL)!
    
    let images = try? values.decode([Sweet.EntityModel.ImageModel].self, forKey: .images)
    self.images = images ?? []
    
    self.status = try? values.decode(Int.self, forKey: .status)
    
    self.title = try? values.decode(String.self, forKey: .title)
    self.description = try? values.decode(String.self, forKey: .description)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(start, forKey: .start)
    try container.encode(end, forKey: .end)
    try container.encode(url, forKey: .url)
    try container.encode(expandedURL, forKey: .expandedURL)
    try container.encode(displayURL, forKey: .displayURL)
    try container.encode(unwoundURL, forKey: .unwoundURL)
    try container.encode(images, forKey: .images)
    try container.encode(status, forKey: .status)
    try container.encode(title, forKey: .title)
    try container.encode(description, forKey: .description)
  }
}
