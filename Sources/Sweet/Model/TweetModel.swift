//
//  TweetModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

struct TweetModel: Decodable {
  let id: String
  let text: String
}

struct TweetsResponseModel: Decodable {
  let tweets: [TweetModel]

  private enum CodingKeys: String, CodingKey {
    case tweets = "data"
  }
}

struct TweetResponseModel: Decodable {
  let tweet: TweetModel

  private enum CodingKeys: String, CodingKey {
    case tweet = "data"
  }
}

struct DeleteTweetResponseModel: Decodable {
  let deleted: Bool
  
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }
  
  private enum CodingKeys: String, CodingKey {
    case deleted
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: DataCodingKeys.self)
    let usersInfo = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.deleted = try usersInfo.decode(Bool.self, forKey: .deleted)
  }
}
