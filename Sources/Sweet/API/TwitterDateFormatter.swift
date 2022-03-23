//
//  TwitterDateFormatter.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public class TwitterDateFormatter: ISO8601DateFormatter {
  public override init() {
    super.init()
    self.formatOptions.insert(.withFractionalSeconds)
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
