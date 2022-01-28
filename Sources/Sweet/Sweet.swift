//
//  Sweet.swift
//
//
//  Created by zunda on 2022/01/14.
//

public struct Sweet {
  let bearerTokenApp: String
  let bearerTokenUser: String
  
  static func exampleSweet() -> Sweet {
    let bearerTokenUser = ""
    let bearerTokenApp = ""
    let sweet = Sweet(bearerTokenApp: bearerTokenApp, bearerTokenUser: bearerTokenUser)
    
    return sweet
  }
}
