//
//  HTTPClient.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

struct HTTPClient {
  private static let timeout: Double = 60.0
  
  public static func request(method: HTTPMethod, url: URL, body: Data? = nil, headers: [String: String] = [:], queries: [String: String] = [:], timeout: Double = timeout) async throws -> (Data, URLResponse) {
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    urlComponents.queryItems = queries.map { .init(name: $0, value: $1)}
    
    var request: URLRequest = .init(url: urlComponents.url!)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = headers
    request.httpBody = body
    request.timeoutInterval = timeout
    
    return try await URLSession.shared.data(for: request)
  }
  
  public static func get(url: URL, body: Data? = nil, headers: [String: String] = [:], queries: [String: String] = [:], timeout: Double = timeout) async throws -> (Data, URLResponse) {
    return try await request(method: .GET, url: url, body: body, headers: headers, queries: queries, timeout: timeout)
  }
  
  public static func post(url: URL, body: Data? = nil , headers: [String: String] = [:], queries: [String: String] = [:], timeout: Double = timeout) async throws -> (Data, URLResponse) {
    return try await request(method: .POST, url: url, body: body, headers: headers, queries: queries, timeout: timeout)
  }
  
  public static func delete(url: URL, body: Data? = nil , headers: [String: String] = [:], queries: [String: String] = [:], timeout: Double = timeout) async throws -> (Data, URLResponse) {
    return try await request(method: .DELETE, url: url, body: body, headers: headers, queries: queries, timeout: timeout)
  }
}

@available(iOS, introduced: 13.0, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
  func data(from url: URL) async throws -> (Data, URLResponse) {
    try await withCheckedThrowingContinuation { continuation in
      self.dataTask(with: url) { data, response, error in
        if let error = error {
          return continuation.resume(throwing: error)
        }
        guard let data = data, let response = response else {
          return continuation.resume(throwing: URLError(.badServerResponse))
        }
        continuation.resume(returning: (data, response))
      }.resume()
    }
  }
  
  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    try await withCheckedThrowingContinuation { continuation in
      self.dataTask(with: request) { data, response, error in
        if let error = error {
          return continuation.resume(throwing: error)
        }
        guard let data = data, let response = response else {
          return continuation.resume(throwing: URLError(.badServerResponse))
        }
        continuation.resume(returning: (data, response))
      }.resume()
    }
  }
}

public enum HTTPMethod : String {
  case GET
  case HEAD
  case POST
  case PUT
  case DELETE
  case CONNECT
  case OPTIONS
  case TRACE
  case PATCH
}
