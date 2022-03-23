//
//  TwitterDateFormatter.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public class TwitterDateFormatter: ISO8601DateFormatter {
  override init() {
    super.init()
    self.formatOptions.insert(.withFractionalSeconds)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
