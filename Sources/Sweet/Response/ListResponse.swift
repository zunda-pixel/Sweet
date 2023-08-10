//
//  ListResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// List Response
  public struct ListResponse: Sendable {
    public let list: ListModel
    public let users: [UserModel]
    public let errors: [ResourceError]
  }
}

extension Sweet.ListResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case list = "data"
    case includes
    case errors
  }

  private enum UserIncludesCodingKeys: String, CodingKey {
    case users
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.list = try container.decode(Sweet.ListModel.self, forKey: .list)

    let errors = try container.decodeIfPresent([Sweet.ResourceErrorModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []

    let includeContainer = try? container.nestedContainer(
      keyedBy: UserIncludesCodingKeys.self,
      forKey: .includes
    )

    let users = try includeContainer?.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}

extension Sweet {
  /// Lists Response
  public struct ListsResponse: Sendable {
    public let lists: [ListModel]
    public let meta: MetaModel
    public let users: [UserModel]
    public let errors: [ResourceError]
  }
}

extension Sweet.ListsResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case lists = "data"
    case meta
    case includes
    case errors
  }

  private enum UserIncludesCodingKeys: String, CodingKey {
    case users
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.meta = try container.decode(Sweet.MetaModel.self, forKey: .meta)

    let errors = try container.decodeIfPresent([Sweet.ResourceErrorModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []

    let lists = try container.decodeIfPresent([Sweet.ListModel].self, forKey: .lists)
    self.lists = lists ?? []

    let includeContainer = try? container.nestedContainer(
      keyedBy: UserIncludesCodingKeys.self,
      forKey: .includes
    )

    let users = try includeContainer?.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []

    if self.errors.isEmpty && self.lists.isEmpty && self.meta.resultCount != 0 {
      throw Sweet.InternalResourceError.noResource
    }
  }
}
