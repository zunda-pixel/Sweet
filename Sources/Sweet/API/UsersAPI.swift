//
//  Users.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

@available(macOS 12.0, iOS 13.0, *)
extension Sweet {
  func follow(from fromUserID: String, to toUserID: String) async throws -> (Bool, Bool) {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/post-users-source_user_id-following
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/following")!
    
    let httpMethod: HTTPMethod = .POST
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let followingModel = try JSONDecoder().decode(FollowResponseModel.self, from: data)
    
    return (followingModel.following, followingModel.pendingFollow)
  }
  
  func unFollow(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/delete-users-source_id-following
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/following/\(toUserID)")!
    
    let httpMethod: HTTPMethod = .DELETE
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let unFollowingModel = try JSONDecoder().decode(UnFollowResponseModel.self, from: data)
    
    return unFollowingModel.following
  }
  
  public func fetchFolloing(by userID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-following
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/following")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func fetchFollower(by userID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-followers
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followers")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func lookUpUser(userID: String) async throws -> UserModel {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-id
    
    let url: URL =  .init(string: "https://api.twitter.com/2/users/\(userID)")!
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let userResponseModel = try JSONDecoder().decode(UserResponseModel.self, from: data)
    
    return userResponseModel.user
  }
  
  
  public func lookUpUser(screenID: String) async throws -> UserModel {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by-username-username
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/by/username/\(screenID)")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let userResponseModel = try JSONDecoder().decode(UserResponseModel.self, from: data)
    
    return userResponseModel.user
  }
  
  public func lookUpUsers(userIDs: [String]) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users
    
    let url: URL = .init(string:"https://api.twitter.com/2/users")!//?ids=\(userIDs.joined(separator: ","))")!
    
    let queries = ["ids": userIDs.joined(separator: ",")]
    
    let httpMethod: HTTPMethod = .GET
    
    // TODO Bearerではなく、Oauth1でもいけるはず
    let headers = bearerHeaders// try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers, queries: queries)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func lookUpUsers(screenIDs: [String]) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/by")!
    
    let queries = ["usernames": screenIDs.joined(separator: ",")]
    
    let httpMethod: HTTPMethod = .GET
    // TODO Bearerではなく、Oauth1でもいけるはず
    let headers = bearerHeaders //try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers, queries: queries)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func lookUpMe() async throws -> UserModel {
    // https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-me
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/me")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let userResponseModel = try JSONDecoder().decode(UserResponseModel.self, from: data)
    
    return userResponseModel.user
  }
  
  public func fetchBlocking(by userID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/get-users-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/blocking")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
        
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func blockUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/post-users-user_id-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking")!
    
    let httpMethod: HTTPMethod = .POST
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let blockResponseModel = try JSONDecoder().decode(BlockResponseModel.self, from: data)
    
    return blockResponseModel.blocking
  }
  
  public func unBlockUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/delete-users-user_id-blocking
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/blocking/\(toUserID)")!
    
    let httpMethod: HTTPMethod = .DELETE
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)

    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let blockResponseModel = try JSONDecoder().decode(BlockResponseModel.self, from: data)
    
    return blockResponseModel.blocking
  }
  
  public func fetchMuting(by userID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/get-users-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/muting")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)

    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func muteUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/post-users-user_id-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/muting")!
    
    let httpMethod: HTTPMethod = .POST
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let muteResponseModel = try JSONDecoder().decode(MuteResponseModel.self, from: data)
    
    return muteResponseModel.muting
  }
  
  public func unMuteUser(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/delete-users-user_id-muting
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/muting/\(toUserID)")!
    
    let httpMethod: HTTPMethod = .DELETE
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
    
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let muteResponseModel = try JSONDecoder().decode(MuteResponseModel.self, from: data)
    
    return muteResponseModel.muting
  }
}


