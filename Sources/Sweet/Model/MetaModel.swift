//
//  MetaModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  public struct MetaModel {
    public let resultCount: Int
    public let oldestID: String?
    public let newestID: String?
    public let nextToken: String?
    public let previousToken: String?
    
    public init(resultCount: Int, oldestID: String? = nil, newestID: String? = nil,
                nextToken: String? = nil, previousToken: String? = nil) {
      self.resultCount =  resultCount
      self.oldestID = oldestID
      self.newestID = newestID
      self.nextToken = nextToken
      self.previousToken = previousToken
    }
  }
}

extension Sweet.MetaModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case resultCount = "result_count"
    case oldestID = "oldest_id"
    case newestID = "newest_id"
    case nextToken = "next_token"
    case previousToken = "previous_token"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.resultCount = try values.decode(Int.self, forKey: .resultCount)
    self.oldestID = try? values.decode(String.self, forKey: .oldestID)
    self.newestID = try? values.decode(String.self, forKey: .newestID)
    self.nextToken = try? values.decode(String.self, forKey: .nextToken)
    self.previousToken = try? values.decode(String.self, forKey: .previousToken)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(resultCount, forKey: .resultCount)
    try container.encode(oldestID, forKey: .oldestID)
    try container.encode(newestID, forKey: .newestID)
    try container.encode(nextToken, forKey: .nextToken)
    try container.encode(previousToken, forKey: .previousToken)
  }
}
