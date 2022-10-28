//
//  DirectMessageAttachmentsModel.swift
//

import Foundation

extension Sweet {
  /// DirectMessage Attachments Model for Tweet
  public struct DirectMessageAttachmentsModel: Hashable, Sendable {
    public let mediaKeys: [String]

    public init(mediaKeys: [String] = []) {
      self.mediaKeys = mediaKeys
    }
  }
}

extension Sweet.DirectMessageAttachmentsModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case mediaKeys = "media_keys"
  }
}
