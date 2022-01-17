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