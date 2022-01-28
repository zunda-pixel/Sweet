//
//  ComplianceModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

public enum JobType: String {
  case tweets
  case users
}

public struct ComplianceModel {
  public let type: JobType
  public let id: String
  public let resumble: Bool
  public let uploadURL: URL
  public let uploadExpiresAt: Date
  public let downloadExpiresAt: Date
  public let downloadURL: URL
  public let createdAt: Date
  public let status: String
}

extension ComplianceModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case type
    case id
    case resumable
    case uploadURL = "upload_url"
    case uploadExpiresAt = "upload_expires_at"
    case downloadExpiresAt = "download_expires_at"
    case downloadURL = "download_url"
    case createdAt = "created_at"
    case status
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    let typeRawValue = try values.decode(String.self, forKey: .type)
    self.type = .init(rawValue: typeRawValue)!

    self.id = try values.decode(String.self, forKey: .id)
    self.resumble = try values.decode(Bool.self, forKey: .resumable)
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)

    let uploadURL = try values.decode(String.self, forKey: .uploadURL)
    self.uploadURL = .init(string: uploadURL)!

    let uploadExpiresAt = try values.decode(String.self, forKey: .uploadExpiresAt)
    self.uploadExpiresAt = formatter.date(from: uploadExpiresAt)!

    let downloadExpiresAt = try values.decode(String.self, forKey: .downloadExpiresAt)
    self.downloadExpiresAt = formatter.date(from: downloadExpiresAt)!

    let downloadURL = try values.decode(String.self, forKey: .downloadURL)
    self.downloadURL = .init(string: downloadURL)!

    let createdAt = try values.decode(String.self, forKey: .createdAt)
    self.createdAt = formatter.date(from: createdAt)!

    self.status = try values.decode(String.self, forKey: .status)
  }
}

public struct CompliancesResponseModel: Decodable {
  public let compliances: [ComplianceModel]

  private enum CodingKeys: String, CodingKey {
    case compliances = "data"
  }
}

public struct ComplianceResponseModel: Decodable {
  public let compliance: ComplianceModel

  private enum CodingKeys: String, CodingKey {
    case compliance = "data"
  }
}
