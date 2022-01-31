//
//  Field.swift
//  
//
//  Created by zunda on 2022/01/31.
//

public protocol Field: CaseIterable, RawRepresentable {
  var key: String { get }
}
