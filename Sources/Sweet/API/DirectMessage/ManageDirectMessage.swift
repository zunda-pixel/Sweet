//
//  ManageDirectMessage.swift
//

import Foundation

extension Sweet {
  /// Post Direct Message
  ///  https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations-with-participant_id-messages
  /// - Parameters:
  ///   - participantID: The User ID of the account this one-to-one Direct Message is to be sent to.
  ///   - message: Direct Message Content
  /// - Returns: DirectMessageResponse
  func postDirectMessage(participantID: String, message: NewDirectMessage.Message) async throws -> DirectMessageResultResponse {
    let url = URL(string: "https://api.twitter.com/2/dm_conversations/with/\(participantID)/messages")!
    
    let body = try JSONEncoder().encode(message)
    
    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .post(url: url, body: body, headers: headers)
    
    let (data, urlResponse) = try await session.data(for: request)
    
    if let response = try? JSONDecoder().decode(DirectMessageResultResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
  
  /// Post Direct Message
  /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations-dm_conversation_id-messages
  /// - Parameters:
  ///   - participantID: The User ID of the account this one-to-one Direct Message is to be sent to.
  ///   - message: Direct Message Content
  /// - Returns: DirectMessageResponse
  func postDirectMessage(conversationID: String, message: NewDirectMessage.Message) async throws -> DirectMessageResultResponse {
    let url = URL(string: "https://api.twitter.com/2/dm_conversations/\(conversationID)/messages")!
    
    let body = try JSONEncoder().encode(message)
    
    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .post(url: url, body: body, headers: headers)
    
    let (data, urlResponse) = try await session.data(for: request)
        
    if let response = try? JSONDecoder().decode(DirectMessageResultResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
  
  /// Create Direct Message Group
  /// https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations
  /// - Parameter directMessage: Direct Message
  /// - Returns: DirectMessageResponse
  func createDicrectMessageGroup(directMessage: NewDirectMessage) async throws -> DirectMessageResultResponse {
    let url = URL(string: "https://api.twitter.com/2/dm_conversations")!
    let body = try JSONEncoder().encode(directMessage)
    
    let headers = getBearerHeaders(type: .user)

    let request: URLRequest = .post(url: url, body: body, headers: headers)
    
    let (data, urlResponse) = try await session.data(for: request)
        
    if let response = try? JSONDecoder().decode(DirectMessageResultResponse.self, from: data) {
      return response
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(request: request, data: data, response: urlResponse)
  }
}
