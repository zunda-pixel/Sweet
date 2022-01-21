//
//  Oauth2.swift
//  
//
//  Created by zunda on 2022/01/22.
//

import Foundation

struct Oauth2 {
  static func getBasicAuthorization(user: String, password: String) -> String {
    let value = "\(user):\(password)"
    let encodedValue = value.data(using: .utf8)!
    let endoded64Value = encodedValue.base64EncodedString()
    return endoded64Value
  }
}
