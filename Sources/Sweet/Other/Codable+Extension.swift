//
//  Codable.swift
//

import Foundation

extension JSONEncoder {
  static var twitter: JSONEncoder {
    let encoder = JSONEncoder()

    encoder.dateEncodingStrategy = .custom { date, encoder in
      var container = encoder.singleValueContainer()
      let stringDate = Sweet.TwitterDateFormatter().string(from: date)
      try container.encode(stringDate)
    }

    return encoder
  }
}

extension JSONDecoder {
  static var twitter: JSONDecoder {
    let decoder = JSONDecoder()

    decoder.dateDecodingStrategy = .custom { decoder in
      let container = try decoder.singleValueContainer()
      let stringDate = try container.decode(String.self)
      return Sweet.TwitterDateFormatter().date(from: stringDate)!
    }

    return decoder
  }
}
