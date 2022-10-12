//
//  LookupUsers.swift
//
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  /// Look Up User by User ID
  /// - Parameter userID: User ID
  /// - Returns: User
  public func lookUpUser(userID: String) async throws -> UserResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-id

    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)")!

    let queries: [String: String?] = [
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: authorizeType)

    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)

    if let response = try? JSONDecoder().decode(UserResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Look Up User by Screen ID
  /// - Parameter screenID: Screen User ID
  /// - Returns: User
  public func lookUpUser(screenID: String) async throws -> UserResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by-username-username

    let url: URL = .init(string: "https://api.twitter.com/2/users/by/username/\(screenID)")!

    let queries: [String: String?] = [
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: authorizeType)

    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)

    if let response = try? JSONDecoder().decode(UserResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Look Up Users by User IDs
  /// - Parameter userIDs: User IDs
  /// - Returns: Users
  public func lookUpUsers(userIDs: [String]) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users

    let url: URL = .init(string: "https://api.twitter.com/2/users")!

    let queries: [String: String?] = [
      "ids": userIDs.joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: authorizeType)

    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)

    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Look Up Users by Screen IDs
  /// - Parameter screenIDs: Screen User IDs
  /// - Returns: Users
  public func lookUpUsers(screenIDs: [String]) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by

    let url: URL = .init(string: "https://api.twitter.com/2/users/by")!

    let queries: [String: String?] = [
      "usernames": screenIDs.joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: authorizeType)

    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)

    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  /// Look Up Me(based Bearer Token)
  /// - Returns: User
  public func lookUpMe() async throws -> UserResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-me

    let url: URL = .init(string: "https://api.twitter.com/2/users/me")!

    let queries: [String: String?] = [
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: .user)

    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)

    if let response = try? JSONDecoder().decode(UserResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
