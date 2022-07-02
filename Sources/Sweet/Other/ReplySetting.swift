//
//  ReplySetting.swift
//  
//
//  Created by zunda on 2022/03/22.
//

import Foundation

extension Sweet {
  /// Reply Setting
  public enum ReplySetting: String, CaseIterable {
    case everyone
    case mentionedUsers
    case following
  }
}
