//
//  SpacesResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Spaces Response
  public struct SpacesResponse: Sendable {
    public let spaces: [SpaceModel]
    public let users: [UserModel]
    public let errors: [ResourceError]
  }
}

extension Sweet.SpacesResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case spaces = "data"
    case errors
    case includes
  }
  private enum UserCodingKeys: String, CodingKey {
    case users
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let errors = try container.decodeIfPresent([Sweet.ErrorMessageModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []

    self.spaces = try container.decode([Sweet.SpaceModel].self, forKey: .spaces)

    let includeContainer = try? container.nestedContainer(
      keyedBy: UserCodingKeys.self,
      forKey: .includes
    )

    let users = try includeContainer?.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}

extension Sweet {
  public struct SpaceResponse: Sendable {
    public let space: SpaceModel
    public let users: [UserModel]
  }
}

extension Sweet.SpaceResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case space = "data"
    case includes
  }

  private enum UserCodingKeys: String, CodingKey {
    case users
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.space = try container.decode(Sweet.SpaceModel.self, forKey: .space)

    let includeContainer = try? container.nestedContainer(
      keyedBy: UserCodingKeys.self, forKey: .includes)

    let users = try includeContainer?.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}
