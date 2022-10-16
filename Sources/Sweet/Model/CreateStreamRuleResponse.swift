//
//  CreateStreamRuleResponse.swift
//
//
//  Created by zunda on 2022/10/10.
//

import Foundation

extension Sweet {
  /// Stream Rule Response
  public struct CreateStreamRuleResponse: Sendable {
    public let streamRules: [StreamRuleModel]
    public let meta: CreateStreamRuleMetaModel
  }
}

extension Sweet.CreateStreamRuleResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case streamRules = "data"
    case meta
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.meta = try container.decode(Sweet.CreateStreamRuleMetaModel.self, forKey: .meta)

    if self.meta.summary.created + self.meta.summary.notCreated == 0 {
      self.streamRules = []
    } else {
      self.streamRules = try container.decode([Sweet.StreamRuleModel].self, forKey: .streamRules)
    }
  }
}
