//
//  Oauth1.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation
import CryptoKit

@available(macOS 10.15, iOS 13.0, *)
struct Oauth1 {
  private let consumerKey: String
  private let consumerSecretKey: String
  private let oauthToken: String?
  private let oauthSecretToken: String

  public init(consumerKey: String, consumerSecretKey: String, oauthToken: String? = nil, oauthSecretToken: String = "") {
    self.consumerKey = consumerKey
    self.consumerSecretKey = consumerSecretKey
    self.oauthToken = oauthToken
    self.oauthSecretToken = oauthSecretToken
  }
  
  public func getAuthorization(method: HTTPMethod, url: String) throws -> String {
    let oauthVersion = "1.0"
    let signatureMethod = "HMAC-SHA1"
    let nonce = UUID().uuidString
    let timestamp = String(Int(Date().timeIntervalSince1970))
    
    var oauth_parameters = [
      "oauth_consumer_key": consumerKey,
      "oauth_signature_method": signatureMethod,
      "oauth_timestamp": timestamp,
      "oauth_nonce": nonce,
      "oauth_version": oauthVersion,
    ]
    
    if let oauthToken = oauthToken {
        oauth_parameters["oauth_token"] = oauthToken
    }
    
    let parameterString = getParameterString(parameters: oauth_parameters)
    
    let parameters = [
      method.rawValue,
      url,
      parameterString,
    ]
    
    let baseString = getBaseString(parameters: parameters)
        
    let key = "\(consumerSecretKey.encodeURL()!)&\(oauthSecretToken.encodeURL()!)"

    let signature = getSignature(key: key, message: baseString)

    oauth_parameters["oauth_signature"] = signature

    let joinedOauthValues = oauth_parameters.map{"\($0.encodeURL()!)=\"\($1.encodeURL()!)\""}
        
    let authorization = "OAuth \(joinedOauthValues.joined(separator: ", "))"

    return authorization
  }
  
  private func getParameterString(parameters:[String: String]) -> String {
    let encodedValues = parameters.map {($0.encodeURL()!, $1.encodeURL()!)}
    let dictionary = encodedValues.reduce(into: [String: String]()) { $0[$1.0] = $1.1 }
    let sortedValues = dictionary.sorted { $0.0 < $1.0 } .map { $0 }
    let eachJoinedValues = sortedValues.map { "\($0)=\($1)" }
    let joinedValue = eachJoinedValues.joined(separator: "&")
    return joinedValue
  }
  
  private func getBaseString(parameters: [String]) -> String {
    let encodedValues = parameters.map{ $0.encodeURL()!}
    let joinedValue = encodedValues.joined(separator: "&")
    return joinedValue
  }
  
  private func getSignature(key:String, message:String) -> String {
    let keyData = key.data(using: .utf8)!
    let messageData = message.data(using: .utf8)!
    let symmetricKey = SymmetricKey(data: keyData)
    let signature = HMAC<Insecure.SHA1>.authenticationCode(for: messageData, using: symmetricKey)
    let signatureString = Data(signature).base64EncodedString()
    return signatureString
  }
}

extension String {
  func encodeURL() -> String? {
    // Oauth1.0で許可されている文字列(許可されている文字は変換されない)
    // https://datatracker.ietf.org/doc/html/rfc3986#section-2.3
    let allowedCharacters = CharacterSet.alphanumerics.union(.init(charactersIn: "-._~"))
    return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
  }
}
