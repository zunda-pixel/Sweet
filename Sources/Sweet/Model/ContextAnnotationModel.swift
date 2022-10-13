//
//  ContextAnnotationModel.swift
//
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  /// Context Annotation Model
  public struct ContextAnnotationModel: Hashable, Sendable {
    public let domain: DomainModel
    public let entity: ContextEntityModel

    public init(domain: DomainModel, entity: ContextEntityModel) {
      self.domain = domain
      self.entity = entity
    }
  }
}

extension Sweet.ContextAnnotationModel: Codable {

}
