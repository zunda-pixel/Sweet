//
//  SpaceState.swift
//
//
//  Created by zunda on 2022/03/25.
//

import Foundation

extension Sweet {
  /// Space State
  public enum SpaceState: String, Sendable {
    case all
    case live
    case scheduled
    case ended
  }
}
