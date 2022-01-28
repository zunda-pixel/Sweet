public struct SpaceModel: Decodable {
  public let id: String
  public let state: String
}

public struct SpacesResponseModel: Decodable {
  public let spaces: [SpaceModel]

   private enum CodingKeys: String, CodingKey {
    case spaces = "data"
  }
}

public struct SpaceResponseModel: Decodable {
  public let space: SpaceModel

   private enum CodingKeys: String, CodingKey {
    case space = "data"
  }
}
