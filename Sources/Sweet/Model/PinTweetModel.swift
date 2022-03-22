//
//  PinTweetModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct PinTweetModel {
    public let id: String
    public let text: String
  }
}

extension Sweet.PinTweetModel: Decodable {
  
}
