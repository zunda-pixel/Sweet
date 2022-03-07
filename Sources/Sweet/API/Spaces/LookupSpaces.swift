//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchSpace(spaceID: String, fields: [SpaceField] = []) async throws -> SpaceModel {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)")!
    
    let queries = [
      SpaceField.key: fields.map(\.rawValue).joined(separator: ",")
    ]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let spaceResponseModel = try JSONDecoder().decode(SpaceResponseModel.self, from: data)
    
    return spaceResponseModel.space
  }

  public func fetchSpaces(spaceIDs: [String], fields: [SpaceField] = []) async throws -> [SpaceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces")!
    
    let queries = [
      "ids": spaceIDs.joined(separator: ","),
      SpaceField.key: fields.map(\.rawValue).joined(separator: ",")
    ]

    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let spacesResponseModel = try JSONDecoder().decode(SpacesResponseModel.self, from: data)
    
    return spacesResponseModel.spaces
  }
  
  public func fetchSpaces(creatorIDs: [String], fields: [SpaceField] = []) async throws -> [SpaceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-by-creator-ids
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/by/creator_ids")!
    
    let queries = [
      "user_ids": creatorIDs.joined(separator: ","),
      SpaceField.key: fields.map(\.rawValue).joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let spacesResponseModel = try JSONDecoder().decode(SpacesResponseModel.self, from: data)
    
    return spacesResponseModel.spaces
  }

  public func fetchSpaceBuyers(spaceID: String, fields: [UserField] = []) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-buyers

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/buyers")!
    
    let queries: [String: String?] = [
      UserField.key: fields.map(\.rawValue).joined(separator: ",")
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
            
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }

  public func fetchSpaceTweets(spaceID: String, tweetFields: [TweetField] = [], userFields: [UserField] = []) async throws -> [TweetModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-tweets

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/tweets")!
    
    let queries = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let tweetsResponseModel = try JSONDecoder().decode(TweetsResponseModel.self, from: data)
    
    return tweetsResponseModel.tweets
  }
}
