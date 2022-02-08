//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func searchSpaces(query: String, state: SpaceState = .all, fields: [SpaceField] =  []) async throws -> [SpaceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/search/api-reference/get-spaces-search

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/search")!
    
    let queries = [
      "query": query,
      "state": state.rawValue,
      SpaceField.key: fields.map(\.rawValue).joined(separator: ",")
    ]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let spacesResponseModel = try JSONDecoder().decode(SpacesResponseModel.self, from: data)
    
    return spacesResponseModel.spaces
  }
}

public enum SpaceState: String {
  case all
  case live
  case scheduled
  case ended
}
