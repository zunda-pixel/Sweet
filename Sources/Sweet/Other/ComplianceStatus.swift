//
//  ComplianceStatus.swift
//  
//
//  Created by zunda on 2022/03/25.
//

import Foundation

extension Sweet {
  public enum ComplianceStatus: String {
    case created
    case inProgress = "in_progress"
    case failed
    case complete
  }
}
