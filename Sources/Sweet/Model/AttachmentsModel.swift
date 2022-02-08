//
//  File.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct AttachmentsModel {
  let mediaKeys: [String]?
  let pollID: String?
}

extension AttachmentsModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case mediaKeys = "media_keys"
    case pollIDs = "poll_ids"
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    self.mediaKeys = try value.decode([String].self, forKey: .mediaKeys)
    
    let pollIDs = try? value.decode([String].self, forKey: .pollIDs)
    self.pollID = pollIDs?.first
  }
}
