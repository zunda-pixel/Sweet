//
//  CreateStreamRuleMetaModel.swift
//

import Foundation

extension Sweet {
  /// Create Stream Rule Meta Model
  public struct CreateStreamRuleMetaModel: Hashable, Sendable {
    public let sent: Date
    public let summary: StreamRuleSummary

    public init(sent: Date, summary: StreamRuleSummary) {
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

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    let sent = try values.decode(String.self, forKey: .sent)
    self.sent = Sweet.TwitterDateFormatter().date(from: sent)!

    self.summary = try values.decode(Sweet.StreamRuleSummary.self, forKey: .summary)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    let sent = Sweet.TwitterDateFormatter().string(from: sent)
    try container.encode(sent, forKey: .sent)

    try container.encode(summary, forKey: .summary)
  }
}
