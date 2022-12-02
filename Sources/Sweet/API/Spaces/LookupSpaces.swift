//
//  LookupSpaces.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Fetch Space by Space ID
  /// - Parameter spaceID: Space ID
  /// - Returns: Space
  public func space(by spaceID: String) async throws -> SpaceResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)")!

    let queries: [String: String?] = [
      Expansion.key: allSpaceExpansion.joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(SpaceResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch Spaces by Space IDs
  /// - Parameter spaceIDs: Space IDs
  /// - Returns: Spaces
  public func spaces(spaceIDs: [String]) async throws -> SpacesResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/spaces")!

    let queries: [String: String?] = [
      "ids": spaceIDs.joined(separator: ","),
      Expansion.key: allSpaceExpansion.joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(SpacesResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch Spaces that created by user ids
  /// - Parameter creatorIDs: Creator User IDs
  /// - Returns: Spaces
  public func spaces(creatorIDs: [String]) async throws -> SpacesResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-by-creator-ids

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/by/creator_ids")!

    let queries: [String: String?] = [
      "user_ids": creatorIDs.joined(separator: ","),
      Expansion.key: allSpaceExpansion.joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(SpacesResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch Users that buy Space
  /// - Parameter spaceID: Space IDs
  /// - Returns: Users(Buyers)
  public func spaceBuyers(spaceID: String) async throws -> UsersResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-buyers

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/buyers")!

    let queries: [String: String?] = [
      Expansion.key: allUserExpansion.joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(UsersResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Fetch Tweets in Space
  /// - Parameter spaceID: Space ID
  /// - Returns: Tweets
  public func spaceTweets(spaceID: String) async throws -> TweetsResponse {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/lookup/api-reference/get-spaces-id-tweets

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/\(spaceID)/tweets")!

    let queries: [String: String?] = [
      Expansion.key: allTweetExpansion.joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      PlaceField.key: placeFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      PollField.key: pollFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(TweetsResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
