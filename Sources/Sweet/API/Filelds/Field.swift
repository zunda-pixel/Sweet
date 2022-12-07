//
//  Field.swift
//

protocol Field: CaseIterable, RawRepresentable, CodingKey {
  static var key: String { get }
}
