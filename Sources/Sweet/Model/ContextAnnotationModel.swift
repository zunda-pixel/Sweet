//
//  ContextAnnotationModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

extension Sweet {
  public struct ContextAnnotationModel {
    public let domain: DomainModel
    public let entity: ContextEntityModel
  }
}

extension Sweet.ContextAnnotationModel: Decodable {
  
}


