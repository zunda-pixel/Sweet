//
//  DirectMessageResponse.swift
//

import Foundation

extension Sweet {
  /// DirectMessages Response
  public struct DirectMessagesResponse: Sendable {
    public let directMessages: [DirectMessageModel]
    public let meta: MetaModel?
    public let users: [UserModel]
    public let medias: [MediaModel]
  }
}

extension Sweet.DirectMessagesResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case directMessages = "data"
    case includes
    case meta
  }

  private enum TweetIncludesCodingKeys: String, CodingKey {
    case media
    case users
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.meta = try container.decodeIfPresent(Sweet.MetaModel.self, forKey: .meta)

    if meta?.resultCount == 0 {
      self.directMessages = []
      self.medias = []
      self.users = []
      return
    }

    self.directMessages = try container.decode(
      [Sweet.DirectMessageModel].self,
      forKey: .directMessages
    )

    let includeContainer = try? container.nestedContainer(
      keyedBy: TweetIncludesCodingKeys.self,
      forKey: .includes
    )

    let medias = try includeContainer?.decodeIfPresent([Sweet.MediaModel].self, forKey: .media)
    self.medias = medias ?? []

    let users = try includeContainer?.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}
