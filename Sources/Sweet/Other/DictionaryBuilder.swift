//
//  DictionaryBuilder.swift
//

import Foundation

@resultBuilder
struct DictionaryBuilder<Key: Hashable, Value> {
  static func buildBlock(_ dictionaries: [Key: Value]...) -> [Key: Value] {
    dictionaries.reduce(into: [:]) {
      $0.merge($1) { _, new in new }
    }
  }
  static func buildOptional(_ dictionary: [Key: Value]?) -> [Key: Value] {
    dictionary ?? [:]
  }
}

extension Dictionary {
  init(@DictionaryBuilder<Key, Value> build: () -> Dictionary) {
    self = build()
  }
}
