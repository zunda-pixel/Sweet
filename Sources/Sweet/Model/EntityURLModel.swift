//
//  EntityURLModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet.EntityModel {
  public struct URLModel {
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
  }
}

extension Sweet.EntityModel.URLModel: Decodable {
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
}
