//
//  CGSize+Extension.swift
//  
//
//  Created by zunda on 2022/04/17.
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

import Foundation

extension CGSize: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(height)
    hasher.combine(width)
  }
}
