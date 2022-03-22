//
//  HideResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  internal struct HideResponse {
    public let hidden: Bool
  }
}

extension Sweet.HideResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case hidden
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let hideInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.hidden = try hideInfo.decode(Bool.self, forKey: .hidden)
  }
}
