//
//  StreamRuleResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation


public struct StreamRuleResponseModel {
  public let streamRules: [StreamRuleModel]
  public let meta: StreamRuleMetaModel
}

extension StreamRuleResponseModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case streamRules = "data"
    case meta
  }
}
