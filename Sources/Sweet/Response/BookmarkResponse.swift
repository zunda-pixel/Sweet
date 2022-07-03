//
//  BookmarkResponse.swift
//
//
//  Created by zunda on 2022/05/21.
//

import Foundation

extension Sweet {
  /// Bookmark Response
  struct BookmarkResponse {
    public let bookmarked: Bool
  }
}

extension Sweet.BookmarkResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case bookmarked
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let hideInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.bookmarked = try hideInfo.decode(Bool.self, forKey: .bookmarked)
  }
}
