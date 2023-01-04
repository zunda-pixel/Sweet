//
//  StreamRuleResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Stream Rule Response
  struct StreamRuleResponse: Sendable {
    let streamRules: [StreamRuleModel]
    let meta: StreamRuleMetaModel
  }
}

extension Sweet.StreamRuleResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case streamRules = "data"
    case meta
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.meta = try container.decode(Sweet.StreamRuleMetaModel.self, forKey: .meta)

    let streamRules = try container.decodeIfPresent(
      [Sweet.StreamRuleModel].self, forKey: .streamRules)
    self.streamRules = streamRules ?? []
  }
}
