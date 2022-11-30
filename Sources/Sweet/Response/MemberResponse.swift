//
//  MemberResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Member Response
  struct MemberResponse: Sendable {
    public let isMember: Bool
  }
}

extension Sweet.MemberResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case isMember = "is_member"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let memberContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.isMember = try memberContainer.decode(Bool.self, forKey: .isMember)
  }
}
