//
//  SearchSpaces.swift
//
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

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

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/search")!

    let queries: [String: String?] = [
      "query": query,
      "state": state.rawValue,
      Expansion.key: SpaceExpansion.allCases.map(\.rawValue).joined(separator: ","),
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: authorizeType)

    let (data, urlResponse) = try await session.data(
      for: .get(url: url, headers: headers, queries: queries))

    if let response = try? JSONDecoder().decode(SpacesResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
