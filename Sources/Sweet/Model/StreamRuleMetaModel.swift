//
//  StreamRuleMetaModel.swift
//

import Foundation

extension Sweet {
  /// Stream Rule Meta Model
  public struct StreamRuleMetaModel: Hashable, Sendable {
    public let sent: Date
    public let resultCount: Int?

    public init(
      sent: Date,
      resultCount: Int? = nil
    ) {
      self.sent = sent
      self.resultCount = resultCount
    }
  }
}

extension Sweet.StreamRuleMetaModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case sent
    case resultCount = "result_count"
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.sent = try container.decode(Date.self, forKey: .sent)
    self.resultCount = try container.decodeIfPresent(Int.self, forKey: .resultCount)
  }

  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(sent, forKey: .sent)
    try container.encodeIfPresent(resultCount, forKey: .resultCount)
  }
}
