//
//  UpdateResponseModel.swift
//

import Foundation

extension Sweet {
  /// Update Response
  struct UpdateResponse: Sendable {
    public let updated: Bool
  }
}

extension Sweet.UpdateResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case updated
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let updateContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.updated = try updateContainer.decode(Bool.self, forKey: .updated)
  }
}
