//
//  DictionaryBuilder.swift
//

import Foundation

@resultBuilder
struct DictionaryBuilder<Key: Hashable, Value> {
  static func buildBlock(_ dictionaries: Dictionary<Key, Value>...) -> Dictionary<Key, Value> {
    dictionaries.reduce(into: [:]) {
      $0.merge($1) { _, new in new }
    }
  }
  static func buildOptional(_ dictionary: Dictionary<Key, Value>?) -> Dictionary<Key, Value> {
    dictionary ?? [:]
  }
}

extension Dictionary {
  init(@DictionaryBuilder<Key, Value> build: () -> Dictionary) {
    self = build()
  }
}
