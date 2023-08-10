//
//  CompliancesResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// ComplianceMeta
  struct ComplianceMeta: Sendable, Codable {
    public let resultCount: Int

    private enum CodingKeys: String, CodingKey {
      case resultCount = "result_count"
    }
  }

  /// CompliancesResponse
  struct CompliancesResponse: Sendable {
    public let meta: ComplianceMeta
    public let compliances: [ComplianceJobModel]
  }
}

extension Sweet.CompliancesResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case meta
    case compliances = "data"
  }

  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.meta = try container.decode(Sweet.ComplianceMeta.self, forKey: .meta)

    let compliances = try container.decodeIfPresent(
      [Sweet.ComplianceJobModel].self, forKey: .compliances)
    self.compliances = compliances ?? []
  }
}

extension Sweet {
  struct ComplianceResponse: Sendable {
    public let compliance: ComplianceJobModel
  }
}

extension Sweet.ComplianceResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case compliance = "data"
  }
}
