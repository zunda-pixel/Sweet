//
//  ContextAnnotationModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

public struct ContextAnnotationModel: Decodable {
  let domain: DomainModel
  let entity: ContextEntityModel
}
