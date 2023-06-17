//
//  MuteResponseModel.swift
//
//
//  Created by zunda on 2022/02/08.
//

import Foundation

extension Sweet {
  /// Mute Response
  struct MuteResponse: Sendable {
    public let muting: Bool
  }
}

extension Sweet.MuteResponse: Decodable {
  private enum DataCodingKeys: String, CodingKey {
    case data = "data"
  }

  private enum CodingKeys: String, CodingKey {
    case muting
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DataCodingKeys.self)
    let muteContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    self.muting = try muteContainer.decode(Bool.self, forKey: .muting)
  }
}
