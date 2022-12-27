//
//  ResponseErrorMessage.swift
//

import Foundation

extension Sweet {
  public struct ResponseErrorMessage: Decodable, Sendable {
    public let parameters: [String]
    public let messages: String

    private enum CodingKeys: String, CodingKey {
      case parameters
      case message
    }

    private enum ParameterCodingKeys: String, CodingKey {
      case id
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.messages = try container.decode(String.self, forKey: .message)

      let parameterContainer = try container.nestedContainer(
        keyedBy: ParameterCodingKeys.self,
        forKey: .parameters
      )
      self.parameters = try parameterContainer.decode([String].self, forKey: .id)
    }
  }
}
