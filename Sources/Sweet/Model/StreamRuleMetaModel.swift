//
//  File.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  public struct StreamRuleMetaModel {
    public let sent: Date
    
    public init(sent: Date) {
      self.sent = sent
    }
  }
}

extension Sweet.StreamRuleMetaModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case sent
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    let sent = try values.decode(String.self, forKey: .sent)
    self.sent = Sweet.TwitterDateFormatter().date(from: sent)!
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(sent, forKey: .sent)
  }
}
