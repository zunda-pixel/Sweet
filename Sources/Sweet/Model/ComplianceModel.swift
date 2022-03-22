//
//  ComplianceModel.swift
//  
//
//  Created by zunda on 2022/01/14.
//

import Foundation

extension Sweet {
  public struct ComplianceModel {
    public let type: JobType
    public let name: String
    public let id: String
    public let resumble: Bool
    public let uploadURL: URL
    public let uploadExpiresAt: Date
    public let downloadExpiresAt: Date
    public let downloadURL: URL
    public let createdAt: Date
    public let status: String
  }
}

extension Sweet.ComplianceModel: Decodable {
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
    
    let formatter = TwitterDateFormatter()
    
    let uploadExpiresAt: String = try values.decode(String.self, forKey: .uploadExpiresAt)
    self.uploadExpiresAt = formatter.date(from: uploadExpiresAt)!
    
    let downloadExpiresAt: String = try values.decode(String.self, forKey: .downloadExpiresAt)
    self.downloadExpiresAt = formatter.date(from: downloadExpiresAt)!
    
    let createdAt: String = try values.decode(String.self, forKey: .createdAt)
    self.createdAt = formatter.date(from: createdAt)!
  }
}
