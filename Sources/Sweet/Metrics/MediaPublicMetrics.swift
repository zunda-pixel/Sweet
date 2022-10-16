//
//  MediaPublicMetrics.swift
//

import Foundation

extension Sweet {
  public struct MediaPublicMetrics: Sendable, Hashable {
    public let viewCount: Int
  }
}

extension Sweet.MediaPublicMetrics: Codable {
  private enum CodingKeys: String, CodingKey {
    case viewCount = "view_count"
  }
}
