//
//  DeleteResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Delete Response
  struct DeleteResponse: Sendable {
    public let deleted: Bool
  }
}

extension Sweet.DeleteResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case deleted
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let deleteContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.deleted = try deleteContainer.decode(Bool.self, forKey: .deleted)
  }
}
