//
//  ResponseErrorModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  /// Error that includes API Error
  public struct ResponseErrorModel {
    public let messages: [String]
    public let title: String
    public let detail: String
    public let type: String
    public let status: Int?

    private struct ErrorMessageModel: Decodable {
      public let message: String
    }
  }
}

extension Sweet.ResponseErrorModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case errors
    case title
    case detail
    case type
    case status
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
        
    if let messages = try? values.decode([ErrorMessageModel].self, forKey: .errors) {
      self.messages = messages.map(\.message)
    } else {
      self.messages = []
    }
    
    self.title = try values.decode(String.self, forKey: .title)
    self.detail = try values.decode(String.self, forKey: .detail)
    self.type = try values.decode(String.self, forKey: .type)
    self.status = try? values.decode(Int.self, forKey: .status)
  }
}
