//
//  MetaModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

public struct MetaModel {
  public let resultCount: Int
  public let oldestID: String?
  public let newestID: String?
  public let nextToken: String?
  public let previousToken: String?
}

extension MetaModel: Decodable {
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
}
