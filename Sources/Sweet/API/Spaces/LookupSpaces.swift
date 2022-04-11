//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchSpace(spaceID: String) async throws -> SpaceResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)")!
    
    let queries: [String: String?] = [
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(SpaceResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func fetchSpaces(spaceIDs: [String]) async throws -> SpacesResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces")!
    
    let queries: [String: String?] = [
      "ids": spaceIDs.joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(SpacesResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func fetchSpaces(creatorIDs: [String]) async throws -> SpacesResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-by-creator-ids
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/by/creator_ids")!
    
    let queries: [String: String?] = [
      "user_ids": creatorIDs.joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(SpacesResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func fetchSpaceBuyers(spaceID: String) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-buyers
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/buyers")!
    
    let queries: [String: String?] = [
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func fetchSpaceTweets(spaceID: String) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/tweets")!
    
    let queries: [String: String?] = [
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allTweetExpansion.joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(TweetsResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
