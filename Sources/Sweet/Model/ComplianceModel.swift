//
//  ComplianceModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

extension Sweet {
  public struct ComplianceModel {
    public let id: String
    public let name: String
    public let createdAt: Date
    public let type: JobType
    public let resumble: Bool
    public let uploadURL: URL
    public let uploadExpiresAt: Date
    public let downloadURL: URL
    public let downloadExpiresAt: Date
    public let status: String
    
    public init(id: String, name: String, createdAt: Date, type: JobType, resumble: Bool,
                uploadURL: URL, uploadExpiresAt: Date, downloadExpiresAt: Date, downloadURL: URL,status: String) {
      self.id = id
      self.name = name
      self.createdAt = createdAt
      self.type = type
      self.resumble = resumble
      self.uploadURL = uploadURL
      self.uploadExpiresAt = uploadExpiresAt
      self.downloadURL = downloadURL
      self.downloadExpiresAt = downloadExpiresAt
      self.status = status
    }
  }
}

extension Sweet.ComplianceModel: Codable {
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
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    let typeRawValue = try values.decode(String.self, forKey: .type)
    self.type = .init(rawValue: typeRawValue)!
    
    self.id = try values.decode(String.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name)
    self.resumble = try values.decode(Bool.self, forKey: .resumable)
    self.status = try values.decode(String.self, forKey: .status)
    
    let uploadURL = try values.decode(String.self, forKey: .uploadURL)
    self.uploadURL = .init(string: uploadURL)!
    
    let downloadURL: String = try values.decode(String.self, forKey: .downloadURL)
    self.downloadURL = .init(string: downloadURL)!
    
    let formatter = Sweet.TwitterDateFormatter()
    
    let uploadExpiresAt: String = try values.decode(String.self, forKey: .uploadExpiresAt)
    self.uploadExpiresAt = formatter.date(from: uploadExpiresAt)!
    
    let downloadExpiresAt: String = try values.decode(String.self, forKey: .downloadExpiresAt)
    self.downloadExpiresAt = formatter.date(from: downloadExpiresAt)!
    
    let createdAt: String = try values.decode(String.self, forKey: .createdAt)
    self.createdAt = formatter.date(from: createdAt)!
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type.rawValue, forKey: .type)
    try container.encode(name, forKey: .name)
    try container.encode(id, forKey: .id)
    try container.encode(resumble, forKey: .resumable)
    try container.encode(uploadURL, forKey: .uploadURL)
    try container.encode(uploadExpiresAt, forKey: .uploadExpiresAt)
    try container.encode(downloadURL, forKey: .downloadURL)
    try container.encode(createdAt, forKey: .createdAt)
    try container.encode(status, forKey: .status)
  }
}
