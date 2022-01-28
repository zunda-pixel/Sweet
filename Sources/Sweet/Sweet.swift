//
//  Sweet.swift
//
//
//  Created by zunda on 2022/01/14.
//

public struct Sweet {
  public let bearerTokenApp: String
  public let bearerTokenUser: String
  
  public init(app bearerTokenApp: String, user bearerTokenUser: String) {
    self.bearerTokenApp = bearerTokenApp
    self.bearerTokenUser = bearerTokenUser
  }
  
  internal static func sweetForTest() -> Sweet {
    let bearerTokenUser = ""
    let bearerTokenApp = ""
    let sweet = Sweet(app: bearerTokenApp, user: bearerTokenUser)
    
    return sweet
  }
}
