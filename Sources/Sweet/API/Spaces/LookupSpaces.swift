//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation

extension Sweet {
  func fetchSpace(spaceID: String) async throws -> SpaceModel {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)")!
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let spaceResponseModel = try JSONDecoder().decode(SpaceResponseModel.self, from: data)
    
    return spaceResponseModel.space
  }

  func fetchSpaces(spaceIDs: [String]) async throws -> [SpaceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces")!
    
    let queries = ["ids": spaceIDs.joined(separator: ",")]

    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let spacesResponseModel = try JSONDecoder().decode(SpacesResponseModel.self, from: data)
    
    return spacesResponseModel.spaces
  }

  func fetchSpaceBuyers(spaceID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-buyers

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/buyers")!
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }

  func fetchSpaceTweets(spaceID: String) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-tweets

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/tweets")!
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}