//
//  SearchSpaces.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Search Spaces by Query
  /// - Parameters:
  ///   - query: Query
  ///   - state: Space State
  /// - Returns: Spaces
  public func searchSpaces(by query: String, state: SpaceState = .all) async throws
    -> SpacesResponse
  {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/search/api-reference/get-spaces-search

    let method: HTTPMethod = .get

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/search")!

    let queries: [String: String?] = [
      "query": query,
      "state": state.rawValue,
      Expansion.key: allSpaceExpansion.joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(SpacesResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
