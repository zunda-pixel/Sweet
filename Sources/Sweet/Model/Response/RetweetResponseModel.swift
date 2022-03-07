//
//  RetweetResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct RetweetResponseModel: Decodable {
  public let retweeted: Bool
  
  public init(retweeted: Bool) {
    self.retweeted = retweeted
  }
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case retweeted
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let retweetedInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.retweeted = try retweetedInfo.decode(Bool.self, forKey: .retweeted)
  }
}
