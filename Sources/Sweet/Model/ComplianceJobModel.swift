//
//  ComplianceModel.swift
//
//
//  Created by zunda on 2022/01/14.
//

import Foundation

extension Sweet {
  /// Compliance Model
  public struct ComplianceJobModel: Hashable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let createdAt: Date
    public let type: JobType
    public let resumable: Bool
    public let uploadURL: URL
    public let uploadExpiresAt: Date
    public let downloadURL: URL
    public let downloadExpiresAt: Date
    public let status: JobStatus

    public init(
      id: String,
      name: String,
      createdAt: Date,
      type: JobType,
      resumable: Bool,
      uploadURL: URL,
      uploadExpiresAt: Date,
      downloadExpiresAt: Date,
      downloadURL: URL,
      status: JobStatus
    ) {
      self.id = id
      self.name = name
      self.createdAt = createdAt
      self.type = type
      self.resumable = resumable
      self.uploadURL = uploadURL
      self.uploadExpiresAt = uploadExpiresAt
      self.downloadURL = downloadURL
      self.downloadExpiresAt = downloadExpiresAt
      self.status = status
    }
  }
}

extension Sweet.ComplianceJobModel: Codable {
  private enum CodingKeys: String, CodingKey {
    case type
    case id
    case name
    case resumable
    case uploadURL = "upload_url"
    case uploadExpiresAt = "upload_expires_at"
    case downloadExpiresAt = "download_expires_at"
    case downloadURL = "download_url"
    case createdAt = "created_at"
    case status
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let typeRawValue = try container.decode(String.self, forKey: .type)
    self.type = Sweet.JobType(rawValue: typeRawValue)!

    self.id = try container.decode(String.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.resumable = try container.decode(Bool.self, forKey: .resumable)

    let status = try container.decode(String.self, forKey: .status)
    self.status = Sweet.JobStatus(rawValue: status)!

    self.uploadURL = try container.decode(URL.self, forKey: .uploadURL)

    self.downloadURL = try container.decode(URL.self, forKey: .downloadURL)

    self.uploadExpiresAt = try container.decode(Date.self, forKey: .uploadExpiresAt)

    self.downloadExpiresAt = try container.decode(Date.self, forKey: .downloadExpiresAt)

    self.createdAt = try container.decode(Date.self, forKey: .createdAt)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type.rawValue, forKey: .type)
    try container.encode(name, forKey: .name)
    try container.encode(id, forKey: .id)
    try container.encode(resumable, forKey: .resumable)
    try container.encode(uploadURL, forKey: .uploadURL)
    try container.encode(status.rawValue, forKey: .status)
    try container.encode(downloadURL, forKey: .downloadURL)

    try container.encode(uploadExpiresAt, forKey: .uploadExpiresAt)
    try container.encode(createdAt, forKey: .createdAt)
    try container.encode(downloadExpiresAt, forKey: .downloadExpiresAt)
    try container.encode(createdAt, forKey: .createdAt)
  }
}
