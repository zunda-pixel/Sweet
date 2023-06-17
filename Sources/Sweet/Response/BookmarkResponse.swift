//
//  BookmarkResponse.swift
//

extension Sweet {
  /// Bookmark Response
  struct BookmarkResponse: Sendable {
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

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let bookmarkContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.bookmarked = try bookmarkContainer.decode(Bool.self, forKey: .bookmarked)
  }
}
