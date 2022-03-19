//
//  ContextEntityModel.swift
//  
//
//  Created by zunda on 2022/03/13.
//

import Foundation

public struct ContextEntityModel {
  public let id: String
  public let name: String
  public let description: String
}

extension ContextEntityModel: Decodable {
  
}
