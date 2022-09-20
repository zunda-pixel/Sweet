//
//  DomainModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  /// Domain Model
  public struct DomainModel: Hashable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let description: String
    
    public init(id: String, name: String, description: String) {
      self.id = id
      self.name = name
      self.description = description
    }
  }
}

extension Sweet.DomainModel: Codable {
  
}
