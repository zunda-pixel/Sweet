//
//  ListModel.swift
//  
//
//  Created by zunda on 2022/01/17.
//

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
    case isMember
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