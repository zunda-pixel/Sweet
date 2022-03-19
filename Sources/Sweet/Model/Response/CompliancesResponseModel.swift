//
//  CompliancesResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct CompliancesResponseModel {
  public let compliances: [ComplianceModel]
}

extension CompliancesResponseModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case compliances = "data"
  }
}

public struct ComplianceResponseModel {
  public let compliance: ComplianceModel
}

extension ComplianceResponseModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case compliance = "data"
  }
}
