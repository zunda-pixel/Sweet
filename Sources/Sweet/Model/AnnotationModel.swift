//
//  AnnotationModel.swift
//

import Foundation

extension Sweet {
  /// Annotation Model
  public struct AnnotationModel: Hashable, Sendable {
    public let start: Int
    public let end: Int
    public let probability: Double
    public let type: AnnotationType
    public let normalizedText: String
    
    public init(start: Int, end: Int, probability: Double, type: AnnotationType, normalizedText: String) {
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
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.start = try container.decode(Int.self, forKey: .start)
    self.end = try container.decode(Int.self, forKey: .end)
    self.probability = try container.decode(Double.self, forKey: .probability)
    self.normalizedText = try container.decode(String.self, forKey: .normalizedText)
    
    let type = try container.decode(String.self, forKey: .type)
    self.type = .init(rawValue: type)!
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(start, forKey: .start)
    try container.encode(end, forKey: .end)
    try container.encode(probability, forKey: .probability)
    try container.encode(normalizedText, forKey: .normalizedText)
    try container.encode(type.rawValue, forKey: .type)
  }
}
