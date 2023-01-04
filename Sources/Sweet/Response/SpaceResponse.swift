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
    public let meta: MetaModel?
  }
}

extension Sweet.SpacesResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case spaces = "data"
    case errors
    case includes
    case meta
  }
  
  private enum UserCodingKeys: String, CodingKey {
    case users
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.meta = try container.decodeIfPresent(Sweet.MetaModel.self, forKey: .meta)
    
    let errors = try container.decodeIfPresent([Sweet.ResourceErrorModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []

    let spaces = try container.decodeIfPresent([Sweet.SpaceModel].self, forKey: .spaces)
    self.spaces = spaces ?? []

    if self.errors.isEmpty && self.spaces.isEmpty && self.meta?.resultCount != 0 {
      throw Sweet.InternalResourceError.noResource
    }

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
    public let errors: [ResourceError]
  }
}

extension Sweet.SpaceResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case space = "data"
    case includes
    case errors
  }

  private enum UserCodingKeys: String, CodingKey {
    case users
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let errors = try container.decodeIfPresent([Sweet.ResourceErrorModel].self, forKey: .errors)
    self.errors = errors?.map(\.error) ?? []
    
    self.space = try container.decode(Sweet.SpaceModel.self, forKey: .space)

    let includeContainer = try? container.nestedContainer(
      keyedBy: UserCodingKeys.self,
      forKey: .includes
    )

    let users = try includeContainer?.decodeIfPresent([Sweet.UserModel].self, forKey: .users)
    self.users = users ?? []
  }
}
