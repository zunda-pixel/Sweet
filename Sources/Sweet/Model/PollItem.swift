//
//  PollItem.swift
//  
//
//  Created by zunda on 2022/03/22.
//

import Foundation


extension Sweet {
  public struct PollItem {
    public let position: Int
    public let label: String
    public let votes: Int
    
    public init(position: Int, label: String, votes: Int) {
      self.position = position
      self.label = label
      self.votes = votes
    }
  }
}

extension Sweet.PollItem: Codable {
  
}
