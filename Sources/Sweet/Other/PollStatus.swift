//
//  PollStatus.swift
//  
//
//  Created by zunda on 2022/03/22.
//

import Foundation

extension Sweet {
  /// Poll Status
  public enum PollStatus: String, Sendable {
    case isOpen = "open"
    case isClosed = "closed"
  }
}
