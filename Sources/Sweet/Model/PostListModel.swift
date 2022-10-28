//
//  SendListModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Post List Model
  public struct PostListModel: Hashable, Sendable {
    public let name: String?
    public let description: String?
    public let isPrivate: Bool?
  }
}

extension Sweet.PostListModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case name
    case description
    case isPrivate = "private"
  }
}
