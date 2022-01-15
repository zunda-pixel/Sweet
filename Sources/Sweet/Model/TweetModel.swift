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
