//
//  LookupUsers.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Look Up User by User ID
  /// - Parameter userID: User ID
  /// - Returns: User
  public func user(userID: String) async throws -> UserResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-id

    let method: HTTPMethod = .get
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)")!

    let queries: [String: String?] = [
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ]
    
    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UserResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Look Up User by Screen ID
  /// - Parameter screenID: Screen User ID
  /// - Returns: User
  public func user(screenID: String) async throws -> UserResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by-username-username

    let method: HTTPMethod = .get
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/by/username/\(screenID)")!

    let queries: [String: String?] = [
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UserResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Look Up Users by User IDs
  /// - Parameter userIDs: User IDs
  /// - Returns: Users
  public func users(userIDs: [String]) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users

    let method: HTTPMethod = .get
    
    let url: URL = .init(string: "https://api.twitter.com/2/users")!

    let queries: [String: String?] = [
      "ids": userIDs.joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ]
    
    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Look Up Users by Screen IDs
  /// - Parameter screenIDs: Screen User IDs
  /// - Returns: Users
  public func users(screenIDs: [String]) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by

    let method: HTTPMethod = .get
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/by")!

    let queries: [String: String?] = [
      "usernames": screenIDs.joined(separator: ","),
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ]
    
    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Look Up Me(based Bearer Token)
  /// - Returns: User
  public func me() async throws -> UserResponse {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-me

    let method: HTTPMethod = .get
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/me")!

    let queries: [String: String?] = [
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(UserResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
