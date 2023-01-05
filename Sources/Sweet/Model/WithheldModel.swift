//
//  WithheldModel.swift
//

import Foundation

extension Sweet {
  /// Withheld Model
  public struct WithheldModel: Hashable, Sendable {
    public let copyright: Bool?
    public let countryCodes: [String]
    public let scope: WithheldScope?

    public init(copyright: Bool? = nil, countryCodes: [String] = [], scope: WithheldScope) {
      self.copyright = copyright
      self.countryCodes = countryCodes
      self.scope = scope
    }
  }
}

extension Sweet.WithheldModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case copyright
    case countryCodes = "country_codes"
    case scope
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.copyright = try container.decodeIfPresent(Bool.self, forKey: .copyright)
    self.countryCodes = try container.decode([String].self, forKey: .countryCodes)

    let scope = try container.decodeIfPresent(String.self, forKey: .scope)
    self.scope = scope.map { Sweet.WithheldScope(rawValue: $0)! }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(copyright, forKey: .copyright)
    try container.encode(countryCodes, forKey: .countryCodes)
    try container.encodeIfPresent(scope?.rawValue, forKey: .scope)
  }
}
