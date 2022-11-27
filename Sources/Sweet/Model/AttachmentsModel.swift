//
//  AttachmentsModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Attachments Model for Tweet
  public struct AttachmentsModel: Hashable, Sendable {
    public let mediaKeys: [String]
    public let pollID: String?

    public init(mediaKeys: [String] = [], pollID: String? = nil) {
      self.mediaKeys = mediaKeys
      self.pollID = pollID
    }
  }
}

extension Sweet.AttachmentsModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case mediaKeys = "media_keys"
    case pollIDs = "poll_ids"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let mediaKeys = try container.decodeIfPresent([String].self, forKey: .mediaKeys)
    self.mediaKeys = mediaKeys ?? []

    let pollIDs = try container.decodeIfPresent([String].self, forKey: .pollIDs)
    self.pollID = pollIDs?.first
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(mediaKeys, forKey: .mediaKeys)
    try container.encode([pollID].compactMap { $0 }, forKey: .pollIDs)
  }
}
