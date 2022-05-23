//
//  EntityAnnotationModel.swift
//
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  public struct AnnotationModel: Hashable {
    public let start: Int
    public let end: Int
    public let probability: Int
    public let type: String
    public let normalizedText: String
    
    public init(start: Int, end: Int, probability: Int, type: String, normalizedText: String) {
      self.start = start
      self.end = end
      self.probability = probability
      self.type = type
      self.normalizedText = normalizedText
    }
  }
}

extension Sweet.AnnotationModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case start
    case end
    case probability
    case type
    case normalizedText = "normalized_text"
  }
}
