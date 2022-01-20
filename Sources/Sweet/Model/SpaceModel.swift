struct SpaceModel: Decodable {
  let id: String
  let state: String
}

struct SpacesResponseModel: Decodable {
  let spaces: [SpaceModel]

   private enum CodingKeys: String, CodingKey {
    case spaces = "data"
  }
}

struct SpaceResponseModel: Decodable {
  let space: SpaceModel

   private enum CodingKeys: String, CodingKey {
    case space = "data"
  }
}