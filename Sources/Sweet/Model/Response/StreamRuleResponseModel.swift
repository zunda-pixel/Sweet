//
//  StreamRuleResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation


public struct StreamRuleResponseModel: Decodable {
  public let streamRules: [StreamRuleModel]
  
  private enum CodingKeys: String, CodingKey {
    case streamRules = "data"
  }
}
