//
//  LookupUsers.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func lookUpUser(userID: String, fields: [UserField]? = nil) async throws -> UserModel {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-id
    
    let url: URL =  .init(string: "https://api.twitter.com/2/users/\(userID)")!
    
    var queries: [String: String?] = [:]
    
    if let fields = fields {
      queries[UserField.key] = fields.map(\.rawValue).joined(separator: ",")
    }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let userResponseModel = try JSONDecoder().decode(UserResponseModel.self, from: data)
    
    return userResponseModel.user
  }
  
  public func lookUpUser(screenID: String, fields: [UserField]? = nil) async throws -> UserModel {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by-username-username
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/by/username/\(screenID)")!
    
    var queries: [String: String?] = [:]
    
    if let fields = fields {
      queries[UserField.key] = fields.map(\.rawValue).joined(separator: ",")
    }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let userResponseModel = try JSONDecoder().decode(UserResponseModel.self, from: data)
    
    return userResponseModel.user
  }
  
  public func lookUpUsers(userIDs: [String], fields: [UserField]? = nil) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users
    
    let url: URL = .init(string:"https://api.twitter.com/2/users")!//?ids=\(userIDs.joined(separator: ","))")!
    
    var queries = ["ids": userIDs.joined(separator: ",")]
          
    if let fields = fields {
      queries[UserField.key] = fields.map(\.rawValue).joined(separator: ",")
    }
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func lookUpUsers(screenIDs: [String], fields: [UserField]? = nil) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/by")!
    
    var queries = ["usernames": screenIDs.joined(separator: ",")]
        
    if let fields = fields {
      queries[UserField.key] = fields.map(\.rawValue).joined(separator: ",")
    }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func lookUpMe(fields: [UserField]? = nil) async throws -> UserModel {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-me
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/me")!
    
    var queries: [String: String?] = [:]
        
    if let fields = fields {
      queries[UserField.key] = fields.map(\.rawValue).joined(separator: ",")
    }
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
    
    let userResponseModel = try JSONDecoder().decode(UserResponseModel.self, from: data)
    
    return userResponseModel.user
  }
}
