//
//  Expansion.swift
//  
//
//  Created by zunda on 2022/01/31.
//

public protocol Expansion: CaseIterable, RawRepresentable, CodingKey {
  static var key: String { get }
}

extension Expansion {
  static public var key: String { "expansions" }
}
