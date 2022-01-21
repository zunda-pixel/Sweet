//
//  ListModel.swift
//  
//
//  Created by zunda on 2022/01/17.
//

struct SendListModel: Codable {
  let name: String?
  let description: String?
  let isPrivate: Bool?
  
  private enum CodingKeys: String, CodingKey {
    case name
    case description
    case isPrivate = "private"
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if let name = name {
      try container.encode(name, forKey: .name)
    }
    if let description = description {
      try container.encode(description, forKey: .description)
    }
    if let isPrivate = isPrivate  {
      try container.encode(isPrivate, forKey: .isPrivate)
    }
  }
}

struct ListModel: Decodable {
	let id: String
	let name: String
}

struct ListResponseModel: Decodable {
	let list: ListModel

	private enum CodingKeys: String, CodingKey {
		case list = "data"
  }
}

struct ListsResponseModel: Decodable {
	let lists: [ListModel]

	private enum CodingKeys: String, CodingKey {
		case lists = "data"
  }
}

struct MemberResponseModel: Decodable {
  let isMember: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case isMember = "is_member"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.isMember = try usersInfo.decode(Bool.self, forKey: .isMember)
  }
}

struct PinResponseModel: Decodable {
  let pinned: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case pinned
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.pinned = try usersInfo.decode(Bool.self, forKey: .pinned)
  }
}

struct UpdateResponseModel: Decodable {
  let updated: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case updated
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.updated = try usersInfo.decode(Bool.self, forKey: .updated)
  }
}
