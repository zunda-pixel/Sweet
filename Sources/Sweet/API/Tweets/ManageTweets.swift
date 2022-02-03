//
//  ManageTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

public struct PostTweetModel: Encodable {
  let text: String?
  let directMessageDeepLink: URL?
  let forSuperFollowersOnly: Bool
  let geo: GeoModel?
  let media: MediaModel?
  let poll: PollModel?
  let quoteTweetID: String?
  let reply: ReplyModel?
  let replySettings: ReplyOption?
  
  init(text: String? = nil, direcrMessageDeepLink: URL? = nil, forSuperFollowersOnly: Bool = false,
       geo: GeoModel? = nil, media: MediaModel? = nil, poll: PollModel? = nil, quoteTweetID: String? = nil,
       reply: ReplyModel? = nil, replySettings: ReplyOption? = nil) {
    self.text = text
    self.directMessageDeepLink = direcrMessageDeepLink
    self.forSuperFollowersOnly = forSuperFollowersOnly
    self.geo = geo
    self.media = media
    self.poll = poll
    self.quoteTweetID = quoteTweetID
    self.reply = reply
    self.replySettings = replySettings
  }
  
  private enum CodingKeys: String, CodingKey {
    case text
    case directMessageDeepLink = "direct_message_deep_link"
    case forSuperFollowersOnly = "for_super_followers_only"
    case geo
    case media
    case poll
    case quoteTweetID = "quote_tweet_id"
    case reply
    case replySettings = "reply_settings"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if let text = text { try container.encode(text, forKey: .text) }
    if let directMessageDeepLink = directMessageDeepLink { try container.encode(directMessageDeepLink, forKey: .directMessageDeepLink) }
    try container.encode(forSuperFollowersOnly, forKey: .forSuperFollowersOnly)
    if let geo = geo { try container.encode(geo, forKey: .geo) }
    if let media = media { try container.encode(media, forKey: .media) }
    if let poll = poll { try container.encode(poll, forKey: .poll) }
    if let quoteTweetID = quoteTweetID { try container.encode(quoteTweetID, forKey: .quoteTweetID) }
    if let reply = reply { try container.encode(reply, forKey: .reply) }
    if let replySettings = replySettings { try container.encode(replySettings.rawValue, forKey: .replySettings) }
  }
}

public enum ReplyOption: String {
  case mentionedUsers
  case following
  case everyone
}


public struct GeoModel: Encodable {
  let placeID: String
  
  private enum CodingKeys: String, CodingKey {
    case placeID = "place_id"
  }
}

public struct PollModel: Encodable {
  let options: [String]
  let durationMinute: Int
  
  private enum CodingKeys: String, CodingKey {
    case options
    case durationMinute = "duration_minute"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(options, forKey: .options)
    try container.encode(durationMinute, forKey: .durationMinute)
  }
}

public struct MediaModel: Encodable {
  let mediaIDs: [String]
  let taggedUserIDs: [String]
  
  private enum CodingKeys: String, CodingKey {
    case mediaIDs = "media_ids"
    case taggedUserIDs = "tagged_user_ids"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(mediaIDs, forKey: .mediaIDs)
    try container.encode(taggedUserIDs, forKey: .taggedUserIDs)
  }
}

public struct ReplyModel: Encodable {
  let excludeReplyUserIDs: [String]
  let inReplyToTweetID: [String]
  
  private enum CodingKeys: String, CodingKey {
    case excludeReplyUserIDs = "exclude_replay_user_ids"
    case inReplyToTweetID = "in_reply_to_tweet_id"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(excludeReplyUserIDs, forKey: .excludeReplyUserIDs)
    try container.encode(inReplyToTweetID, forKey: .inReplyToTweetID)
  }
}

extension Sweet {
  public func createTweet(_ postTweetModel: PostTweetModel) async throws -> TweetModel {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!
        
    let headers = getBearerHeaders(type: .User)
    
    let bodyData = try JSONEncoder().encode(postTweetModel)
    
    print(String(data: bodyData, encoding: .utf8)!)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    print(String(data: data, encoding: .utf8)!)
    
    let tweetResponseModel = try JSONDecoder().decode(TweetResponseModel.self, from: data)
    
    return tweetResponseModel.tweet
  }
  
  public func deleteTweet(by id: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(id)")!
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
    
    let deleteResponseModel = try JSONDecoder().decode(DeleteResponseModel.self, from: data)
    
    return deleteResponseModel.deleted
  }
}
