//
//  LookUpDirectMessage.swift
//

import Foundation
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Get Direct Message Events
  /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_events
  /// - Parameters:
  ///   - eventType: The type of Direct Message event to return. If not included, all types are returned.
  ///   - maxResults: The maximum number of results to be returned in a page. Must be between 1 and 100. The default is 100.
  ///   - paginationToken: Contains either the next_token or previous_token value.
  public func directMessageEvents(
    eventType: DirectMessageEventType? = nil, maxResults: Int = 100, paginationToken: String? = nil
  ) async throws -> DirectMessagesResponse {
    let method: HTTPMethod = .get

    let url = URL(string: "https://api.twitter.com/2/dm_events")!

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      "event_types": eventType?.rawValue,
      DirectMessageField.key: directMessageFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allDirectMessageExpansion.joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(DirectMessagesResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Get Direct Message
  ///　https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_conversations-with-participant_id-dm_events
  /// - Parameters:
  ///   - participantID: Participant ID
  ///   - eventType: The type of Direct Message event to return. If not included, all types are returned.
  ///   - maxResults: The maximum number of results to be returned in a page. Must be between 1 and 100. The default is 100.
  ///   - paginationToken: Contains either the next_token or previous_token value.
  public func directMessageConversations(
    participantID: String, eventType: DirectMessageEventType? = nil, maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> DirectMessagesResponse {
    let method: HTTPMethod = .get

    let url = URL(
      string: "https://api.twitter.com/2/dm_conversations/with/\(participantID)/dm_events")!

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      "event_types": eventType?.rawValue,
      DirectMessageField.key: directMessageFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allDirectMessageExpansion.joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(DirectMessagesResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Get Direct Message
  /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_conversations-dm_conversation_id-dm_events
  /// - Parameters:
  ///   - conversationID: Conversation ID
  ///   - eventType: The type of Direct Message event to return. If not included, all types are returned.
  ///   - maxResults: The maximum number of results to be returned in a page. Must be between 1 and 100. The default is 100.
  ///   - paginationToken: Contains either the next_token or previous_token value.
  public func directMessageConversations(
    conversationID: String, eventType: DirectMessageEventType? = nil, maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> DirectMessagesResponse {
    let method: HTTPMethod = .get

    let url = URL(string: "https://api.twitter.com/2/dm_conversations/\(conversationID)/dm_events")!

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      "event_types": eventType?.rawValue,
      DirectMessageField.key: directMessageFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allDirectMessageExpansion.joined(separator: ","),
    ]

    let removedEmptyQueries = queries.removedEmptyValue

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: removedEmptyQueries)

    let request: URLRequest = .request(
      method: method, url: url, queries: removedEmptyQueries, headers: headers)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter

    if let response = try? decoder.decode(DirectMessagesResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
