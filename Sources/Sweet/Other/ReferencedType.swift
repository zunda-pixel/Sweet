//
//  ReferencedType.swift
//  
//
//  Created by zunda on 2022/03/22.
//

import Foundation

extension Sweet {
  public enum ReferencedType: String {
    case retweeted
    case quoted
    case repliedTo = "replied_to"
  }
}
