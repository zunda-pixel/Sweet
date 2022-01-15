//
//  File.swift
//  
//
//  Created by zunda on 2022/01/14.
//

struct TweetModel: Decodable {
  let id: String
  let author_id: String
  let text: String
  let created_at: String
}
