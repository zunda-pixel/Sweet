//
//  EditControl.swift
//
//
//  Created by zunda on 2022/10/04.
//

import Foundation

extension Sweet {
  /// EditControl
  public struct EditControl: Sendable, Hashable {
    public let isEditEligible: Bool
    public let editableUntil: Date
    public let editsRemaining: Int

    public init(isEditEligible: Bool, editableUntil: Date, editsRemaining: Int) {
      self.isEditEligible = isEditEligible
      self.editableUntil = editableUntil
      self.editsRemaining = editsRemaining
    }
  }
}

extension Sweet.EditControl: Codable {
  private enum CodingKeys: String, CodingKey {
    case isEditEligible = "is_edit_eligible"
    case editableUntil = "editable_until"
    case editsRemaining = "edits_remaining"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.isEditEligible = try container.decode(Bool.self, forKey: .isEditEligible)

    let editableUntilString = try container.decode(String.self, forKey: .editableUntil)
    self.editableUntil = Sweet.TwitterDateFormatter().date(from: editableUntilString)!

    let editsRemaining = try container.decode(Int.self, forKey: .editsRemaining)
    self.editsRemaining = editsRemaining
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(isEditEligible, forKey: .isEditEligible)

    let editableUntil = Sweet.TwitterDateFormatter().string(from: editableUntil)
    try container.encode(editableUntil, forKey: .editableUntil)

    try container.encode(editsRemaining, forKey: .editsRemaining)
  }
}
