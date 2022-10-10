//
//  MediaOrganicMetrics.swift
//

import Foundation

extension Sweet {
  public struct MediaOrganicMetrics: Sendable, Hashable {
    public let viewCount: Int
    public let playback0Count: Int
    public let playback25Count: Int
    public let playback50Count: Int
    public let playback75Count: Int
    public let playback100Count: Int
  }
}

extension Sweet.MediaOrganicMetrics: Codable {
  private enum CodingKeys: String, CodingKey {
    case viewCount = "view_count"
    case playback0Count = "playback_0_count"
    case playback25Count = "playback_25_count"
    case playback50Count = "playback_50_count"
    case playback75Count = "playback_75_count"
    case playback100Count = "playback_100_count"
  }
}
