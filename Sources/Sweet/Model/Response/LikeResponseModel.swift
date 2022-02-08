//
//  LikeResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct LikeResponseModel: Decodable {
  public let liked: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case liked
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let retweetedInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.liked = try retweetedInfo.decode(Bool.self, forKey: .liked)
  }
}
