//
//  ImageModel.swift
//  
//
//  Created by zunda on 2022/03/16.
//

import SwiftUI

extension EntityModel {
  public struct ImageModel {
    public let url: URL
    public let size: CGSize
  }
}

extension EntityModel.ImageModel: Decodable {
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
}
