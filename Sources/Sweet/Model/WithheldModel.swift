//
//  WithheldModel.swift
//

import Foundation

extension Sweet {
  /// Withheld Model
  public struct WithheldModel: Hashable, Sendable {
    public let copyright: Bool?
    public let countryCodes: [String]
    public let scope: WithheldScope

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
    let value = try decoder.container(keyedBy: CodingKeys.self)

    self.copyright = try? value.decode(Bool.self, forKey: .copyright)
    self.countryCodes = try value.decode([String].self, forKey: .countryCodes)

    let scope = try value.decode(String.self, forKey: .scope)
    self.scope = .init(rawValue: scope)!
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(copyright, forKey: .copyright)
    try container.encode(countryCodes, forKey: .countryCodes)
    try container.encode(scope.rawValue, forKey: .scope)
  }
}
