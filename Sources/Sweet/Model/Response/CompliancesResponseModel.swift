//
//  CompliancesResponseModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct CompliancesResponseModel: Decodable {
  public let compliances: [ComplianceModel]

  private enum CodingKeys: String, CodingKey {
    case compliances = "data"
  }
}

public struct ComplianceResponseModel: Decodable {
  public let compliance: ComplianceModel

  private enum CodingKeys: String, CodingKey {
    case compliance = "data"
  }
}
