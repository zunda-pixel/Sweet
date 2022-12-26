//
//  PostTweetModel.swift
//
//
//  Created by zunda on 2022/03/19.
//

import Foundation

extension Sweet {
  /// Post Tweet Model
  public struct PostTweetModel: Sendable {
    public let text: String?
    public let directMessageDeepLink: URL?
    public let forSuperFollowersOnly: Bool
    public let geo: Sweet.PostGeoModel?
    public let media: Sweet.PostMediaModel?
    public let poll: Sweet.PostPollModel?
    public let quoteTweetID: String?
    public let reply: Sweet.ReplyModel?
    public let replySettings: Sweet.ReplySetting?

    public init(
      text: String? = nil,
      directMessageDeepLink: URL? = nil,
      forSuperFollowersOnly: Bool = false,
      geo: Sweet.PostGeoModel? = nil,
      media: Sweet.PostMediaModel? = nil,
      poll: Sweet.PostPollModel? = nil,
      quoteTweetID: String? = nil,
      reply: Sweet.ReplyModel? = nil,
      replySettings: Sweet.ReplySetting? = nil
    ) {
      self.text = text
      self.directMessageDeepLink = directMessageDeepLink
      self.forSuperFollowersOnly = forSuperFollowersOnly
      self.geo = geo
      self.media = media
      self.poll = poll
      self.quoteTweetID = quoteTweetID
      self.reply = reply
      self.replySettings = replySettings
    }
  }
}

extension Sweet.PostTweetModel: Encodable {
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
    try container.encodeIfPresent(text, forKey: .text)
    try container.encodeIfPresent(directMessageDeepLink, forKey: .directMessageDeepLink)
    try container.encode(forSuperFollowersOnly, forKey: .forSuperFollowersOnly)
    try container.encodeIfPresent(geo, forKey: .geo)
    try container.encodeIfPresent(media, forKey: .media)
    try container.encodeIfPresent(poll, forKey: .poll)
    try container.encodeIfPresent(quoteTweetID, forKey: .quoteTweetID)
    try container.encodeIfPresent(reply, forKey: .reply)

    if replySettings != .everyone {  // if `everyone`, does not need value
      try container.encodeIfPresent(replySettings?.rawValue, forKey: .replySettings)
    }
  }
}
