//
//  EntityAnnotationModel.swift
//
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet.EntityModel {
  public struct AnnotationModel {
    public let start: Int
    public let end: Int
    public let probability: Int
    public let type: String
    public let normalizedText: String
  }
}

extension Sweet.EntityModel.AnnotationModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case start
    case end
    case probability
    case type
    case normalizedText = "normalized_text"
  }
}
