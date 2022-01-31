//
//  Expansion.swift
//  
//
//  Created by zunda on 2022/01/31.
//

public protocol Expansion: CaseIterable, RawRepresentable {
  var key: String { get }
}

extension Expansion {
  public var key: String { "expansions" }
}
