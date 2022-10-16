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

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.meta = try container.decode(Sweet.ComplianceMeta.self, forKey: .meta)

    if self.meta.resultCount == 0 {
      self.compliances = []
    } else {
      self.compliances = try container.decode([Sweet.ComplianceJobModel].self, forKey: .compliances)
    }
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
