//
//  AttachmentsModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct AttachmentsModel {
    public let mediaKeys: [String]
    public let pollID: String?
  }
}

extension Sweet.AttachmentsModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case mediaKeys = "media_keys"
    case pollIDs = "poll_ids"
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    let mediaKeys = try? value.decode([String].self, forKey: .mediaKeys)
    self.mediaKeys = mediaKeys ?? []
    
    let pollIDs = try? value.decode([String].self, forKey: .pollIDs)
    self.pollID = pollIDs?.first
  }
}
