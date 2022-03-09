//
//  TopicField.swift
//  
//
//  Created by zunda on 2022/03/08.
//

public enum TopicField: String, Field {
  static public var key: String { "topic.fields" }
  
  case id
  case name
  case description
}
