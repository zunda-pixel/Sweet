//
//  StreamRuleMetaModel.swift
//

import Foundation

extension Sweet {
  /// Stream Rule Meta Model
  public struct StreamRuleMetaModel: Hashable, Sendable {
    public let sent: Date
    public let resultCount: Int?

    public init(sent: Date, resultCount: Int?) {
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

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    let sent = try values.decode(String.self, forKey: .sent)
    self.sent = Sweet.TwitterDateFormatter().date(from: sent)!

    self.resultCount = try? values.decode(Int.self, forKey: .resultCount)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    let stringSent = Sweet.TwitterDateFormatter().string(from: sent)
    try container.encode(stringSent, forKey: .sent)
    try container.encode(resultCount, forKey: .resultCount)
  }
}
