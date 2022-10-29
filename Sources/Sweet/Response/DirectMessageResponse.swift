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
    let values = try decoder.container(keyedBy: CodingKeys.self)

    self.meta = try? values.decode(Sweet.MetaModel.self, forKey: .meta)

    if meta?.resultCount == 0 {
      self.directMessages = []
      self.medias = []
      self.users = []
      return
    }

    self.directMessages = try values.decode(
      [Sweet.DirectMessageModel].self, forKey: .directMessages)

    guard
      let includes = try? values.nestedContainer(
        keyedBy: TweetIncludesCodingKeys.self, forKey: .includes)
    else {
      self.medias = []
      self.users = []
      return
    }

    let medias = try includes.decodeIfPresent([Sweet.MediaModel].self, forKey: .media)
    self.medias = medias ?? []

    let users = try includes.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}
