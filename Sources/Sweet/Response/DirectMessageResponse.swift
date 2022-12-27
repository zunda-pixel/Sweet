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
    public let errors: [ResourceError]
  }
}

extension Sweet.DirectMessagesResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case directMessages = "data"
    case includes
    case meta
    case errors
  }

  private enum TweetIncludesCodingKeys: String, CodingKey {
    case media
    case users
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.meta = try container.decodeIfPresent(Sweet.MetaModel.self, forKey: .meta)
    
    let errors = try container.decodeIfPresent([Sweet.ErrorMessageModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []

    let directMessages = try container.decodeIfPresent(
      [Sweet.DirectMessageModel].self,
      forKey: .directMessages
    )
    
    self.directMessages = directMessages ?? []
    
    if self.errors.isEmpty && self.directMessages.isEmpty {
      throw Sweet.InternalResourceError.noResource
    }

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
