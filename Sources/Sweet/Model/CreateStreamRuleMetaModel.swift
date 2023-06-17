//
//  CreateStreamRuleMetaModel.swift
//

import Foundation

extension Sweet {
  /// Create Stream Rule Meta Model
  public struct CreateStreamRuleMetaModel: Hashable, Sendable {
    public let sent: Date
    public let summary: StreamRuleSummary

    public init(
      sent: Date,
      summary: StreamRuleSummary
    ) {
      self.sent = sent
      self.summary = summary
    }
  }
}

extension Sweet.CreateStreamRuleMetaModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case sent
    case summary
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.sent = try container.decode(Date.self, forKey: .sent)
    self.summary = try container.decode(Sweet.StreamRuleSummary.self, forKey: .summary)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(sent, forKey: .sent)
    try container.encode(summary, forKey: .summary)
  }
}
