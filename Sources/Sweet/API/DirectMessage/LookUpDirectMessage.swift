//
//  LookUpDirectMessage.swift
//

import Foundation

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
    let url = URL(string: "https://api.twitter.com/2/dm_events")!

    let headers = getBearerHeaders(type: .user)

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      "event_types": eventType?.rawValue,
      DirectMessageField.key: directMessageFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allDirectMessageExpansion.joined(separator: ","),
    ].filter { $0.value != nil && !$0.value!.isEmpty }

    let request: URLRequest = .get(url: url, headers: headers, queries: queries)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(DirectMessagesResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Get Direct Message
  ///　https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_conversations-with-participant_id-dm_events
  /// - Parameters:
  ///   - participantID: Participant ID
  ///   - eventType: The type of Direct Message event to returm. If not included, all types are returned.
  ///   - maxResults: The maximum number of results to be returned in a page. Must be between 1 and 100. The default is 100.
  ///   - paginationToken: Contains either the next_token or previous_token value.
  public func directMessageConversations(
    participantID: String, eventType: DirectMessageEventType? = nil, maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> DirectMessagesResponse {
    let url = URL(
      string: "https://api.twitter.com/2/dm_conversations/with/\(participantID)/dm_events")!

    let headers = getBearerHeaders(type: .user)

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      "event_types": eventType?.rawValue,
      DirectMessageField.key: directMessageFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allDirectMessageExpansion.joined(separator: ","),
    ].filter { $0.value != nil && !$0.value!.isEmpty }

    let request: URLRequest = .get(url: url, headers: headers, queries: queries)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(DirectMessagesResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Get Direct Message
  /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_conversations-dm_conversation_id-dm_events
  /// - Parameters:
  ///   - conversationID: Conversation ID
  ///   - eventType: The type of Direct Message event to returm. If not included, all types are returned.
  ///   - maxResults: The maximum number of results to be returned in a page. Must be between 1 and 100. The default is 100.
  ///   - paginationToken: Contains either the next_token or previous_token value.
  public func directMessageConversations(
    conversationID: String, eventType: DirectMessageEventType? = nil, maxResults: Int = 100,
    paginationToken: String? = nil
  ) async throws -> DirectMessagesResponse {
    let url = URL(string: "https://api.twitter.com/2/dm_conversations/\(conversationID)/dm_events")!

    let headers = getBearerHeaders(type: .user)

    let queries: [String: String?] = [
      "max_results": String(maxResults),
      "pagination_token": paginationToken,
      "event_types": eventType?.rawValue,
      DirectMessageField.key: directMessageFields.map(\.rawValue).joined(separator: ","),
      TweetField.key: tweetFields.map(\.rawValue).joined(separator: ","),
      UserField.key: userFields.map(\.rawValue).joined(separator: ","),
      MediaField.key: mediaFields.map(\.rawValue).joined(separator: ","),
      Expansion.key: allDirectMessageExpansion.joined(separator: ","),
    ].filter { $0.value != nil && !$0.value!.isEmpty }

    let request: URLRequest = .get(url: url, headers: headers, queries: queries)

    let (data, urlResponse) = try await session.data(for: request)

    if let response = try? JSONDecoder().decode(DirectMessagesResponse.self, from: data) {
      return response
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
