//
//  CompliancesResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  internal struct CompliancesResponse {
    public let compliances: [ComplianceModel]
  }
}

extension Sweet.CompliancesResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case compliances = "data"
  }
}

extension Sweet {
  internal struct ComplianceResponse {
    public let compliance: ComplianceModel
  }
}

extension Sweet.ComplianceResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case compliance = "data"
  }
}
