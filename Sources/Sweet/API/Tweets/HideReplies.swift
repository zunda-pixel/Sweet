//
//  HideReplies.swift
//

import Foundation
import HTTPClient
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Hide/ UnHide Reply
  /// - Parameters:
  ///   - tweetID: Tweet ID
  ///   - hidden: Hidden Status
  public func hideReply(
    tweetID: String,
    hidden: Bool
  ) async throws {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/hide-replies/api-reference/put-tweets-id-hidden

    let method: HTTPMethod = .put

    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/hidden")!

    let body = ["hidden": hidden]
    let bodyData = try JSONEncoder().encode(body)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: bodyData)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(HideResponse.self, from: data) {
      if hidden == response.hidden {
        return
      } else {
        throw TwitterError.hideReplyError
      }
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw UnknownError(request: request, data: data, response: urlResponse)
  }
}
