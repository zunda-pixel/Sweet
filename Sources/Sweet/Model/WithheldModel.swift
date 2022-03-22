//
//  WithheldModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  public struct WithheldModel {
    public let copyright: Bool?
    public let countryCodes: [String]
    public let scope: WithheldScope
  }
}

extension Sweet.WithheldModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case copyright
    case countryCodes = "country_codes"
    case scope
  }
  
  public init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    
    self.copyright = try? value.decode(Bool.self, forKey: .copyright)
    self.countryCodes = try value.decode([String].self, forKey: .countryCodes)
    
    let scope = try value.decode(String.self, forKey: .scope)
    self.scope  = .init(rawValue: scope)!
  }
}

