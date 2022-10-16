//
//  ReferencedType.swift
//
//
//  Created by zunda on 2022/03/22.
//

import Foundation

extension Sweet {
  /// Referenced Type
  public enum ReferencedType: String, Sendable {
    case retweeted
    case quoted
    case repliedTo = "replied_to"
  }
}
