//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchSpace(spaceID: String, spaceFields: [SpaceField] = [], topicFields: [TopicField] = [], userFields: [UserField] = []) async throws -> SpaceModel {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)")!
    
    let queries = [
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(SpaceResponseModel.self, from: data) {
      return response.space
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func fetchSpaces(spaceIDs: [String], spaceFields: [SpaceField] = [],
                          topicFields: [TopicField] = [], userFields: [UserField] = []) async throws -> [SpaceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces")!
    
    let queries = [
      "ids": spaceIDs.joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(SpacesResponseModel.self, from: data) {
      return response.spaces
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func fetchSpaces(creatorIDs: [String], spaceFields: [SpaceField] = [],
                          topicFields: [TopicField] = [], userFields: [UserField] = []) async throws -> [SpaceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-by-creator-ids
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/by/creator_ids")!
    
    let queries = [
      "user_ids": creatorIDs.joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(SpacesResponseModel.self, from: data) {
      return response.spaces
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func fetchSpaceBuyers(spaceID: String, userFields: [UserField] = [],
                               mediaFields: [MediaField] = [], placeFields: [PlaceField] = [],
                               pollFields: [PollField] = [], tweetFields: [TweetField] = []) async throws -> ([UserModel], MetaModel) {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-buyers
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/buyers")!
    
    let queries: [String: String?] = [
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(UsersResponseModel.self, from: data) {
      return (response.users, response.meta)
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func fetchSpaceTweets(spaceID: String, tweetFields: [TweetField] = [], userFields: [UserField] = [],
                               mediaFields: [MediaField] = [], placeFields: [PlaceField] = [], pollFields: [PollField] = []) async throws -> ([TweetModel], MetaModel) {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/tweets")!
    
    let queries = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(TweetsResponseModel.self, from: data) {
      return (response.tweets, response.meta)
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}
