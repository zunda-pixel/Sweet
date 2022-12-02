//
//  ManageDirectMessage.swift
//

import Foundation
import HTTPMethod

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  /// Post Direct Message
  ///  https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations-with-participant_id-messages
  /// - Parameters:
  ///   - participantID: The User ID of the account this one-to-one Direct Message is to be sent to.
  ///   - message: Direct Message Content
  /// - Returns: DirectMessageResponse
  public func postDirectMessage(participantID: String, message: NewDirectMessage.Message)
    async throws -> DirectMessageResultResponse
  {
    let method: HTTPMethod = .post

    let url = URL(
      string: "https://api.twitter.com/2/dm_conversations/with/\(participantID)/messages")!

    let body = try JSONEncoder().encode(message)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: body)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(DirectMessageResultResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Post Direct Message
  /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations-dm_conversation_id-messages
  /// - Parameters:
  ///   - participantID: The User ID of the account this one-to-one Direct Message is to be sent to.
  ///   - message: Direct Message Content
  /// - Returns: DirectMessageResponse
  public func postDirectMessage(conversationID: String, message: NewDirectMessage.Message)
    async throws -> DirectMessageResultResponse
  {
    let method: HTTPMethod = .post

    let url = URL(string: "https://api.twitter.com/2/dm_conversations/\(conversationID)/messages")!

    let body = try JSONEncoder().encode(message)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: body)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(DirectMessageResultResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }

  /// Create Direct Message Group
  /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations
  /// - Parameter directMessage: Direct Message
  /// - Returns: DirectMessageResponse
  public func createDirectMessageGroup(directMessage: NewDirectMessage) async throws
    -> DirectMessageResultResponse
  {
    let method: HTTPMethod = .post

    let url = URL(string: "https://api.twitter.com/2/dm_conversations")!

    let body = try JSONEncoder().encode(directMessage)

    let headers = getBearerHeaders(httpMethod: method, url: url, queries: [:])

    let request: URLRequest = .request(method: method, url: url, headers: headers, body: body)

    let (data, urlResponse) = try await session.data(for: request)

    let decoder = JSONDecoder.twitter
    
    if let response = try? decoder.decode(DirectMessageResultResponse.self, from: data) {
      return response
    }

    if let response = try? decoder.decode(ResponseErrorModel.self, from: data) {
      throw response.error
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
