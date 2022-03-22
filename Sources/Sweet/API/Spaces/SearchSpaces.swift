//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func searchSpaces(query: String, state: SpaceState = .all, spaceFields: [SpaceField] = [],
                           userFields: [UserField] = [], topicFields: [TopicField] = []) async throws -> [SpaceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/search/api-reference/get-spaces-search
    
    let url: URL = .init(string: "https://api.twitter.com/2/spaces/search")!
    
    let queries: [String: String?] = [
      "query": query,
      "state": state.rawValue,
      SpaceField.key: spaceFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      TopicField.key: topicFields.map(\.rawValue).joined(separator: ","),
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(SpacesResponse.self, from: data) {
      return response.spaces
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}

public enum SpaceState: String {
  case all
  case live
  case scheduled
  case ended
}
