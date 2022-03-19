//
//  PostTweetModel.swift
//  
//
//  Created by zunda on 2022/03/19.
//

import Foundation

public struct PostTweetModel {
  public let text: String?
  public let directMessageDeepLink: URL?
  public let forSuperFollowersOnly: Bool
  public let geo: GeoModel?
  public let media: PostMediaModel?
  public let poll: SendPollModel?
  public let quoteTweetID: String?
  public let reply: ReplyModel?
  public let replySettings: ReplyOption?
}

extension PostTweetModel: Encodable {
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

