//
//  StreamRuleResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation


extension Sweet {
  /// Stream Rule Response
  public struct StreamRuleResponse {
    public let streamRules: [StreamRuleModel]
    public let meta: StreamRuleMetaModel
  }
}

extension Sweet.StreamRuleResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case streamRules = "data"
    case meta
  }
}
