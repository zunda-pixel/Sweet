

enum JobType: String {
  case tweets
  case users
}

struct ComplianceModel {
  let type: String
  let id: String
  let resumble: Bool
  let uploadURL: URL
  let uploadExpiresAt: Date
  let downloadExpiresAt: Date
  let downloadURL: URL
  let createdAt: Date
  let status: String
}

extension ComplianceModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case type
    case id
    case resumble
    case uploadURL = "upload_url"
    case uploadExpiresAt = "download_expires_at"
    case downloadExpiresAt = "download_expires_at"
    case downloadURL = "download_url"
    case createdAt = "created_at"
    case status
  }

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.type = try values.decode(String.self, forKey: .type)
    self.id = try values.decode(String.self, forKey: .id)
    self.resumble = try values.decode(Bool.self, forKey: .resumble)
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)

    let uploadURL = try values.decode(String.self, forKey: .uploadURL)
    self.uploadURL = formatter.date(from: uploadURL)!

    let uploadExpiresAt = try values.decode(String.self, forKey: .uploadExpiresAt)
    self.uploadExpiresAt = .init(string: uploadExpiresAt)!

    let downloadExpiresAt = try values.decode(String.self, forKey: .downloadExpiresAt)
    self.downloadExpiresAt = formatter.date(from: downloadExpiresAt)!

    let downloadURL = try values.decode(String.self, forKey: .downloadURL)
    self.downloadURL = .init(string: downloadURL)!

    let createdAt = try values.decode(String.self, forKey: .createdAt)
    self.createdAt = formatter.date(from: createdAt)!

    self.status = try values.decode(String.self, forKey: .status)
  }
}

struct ComplianceResponseModel: Decodable {
  let compliances: [ComplianceModel]

  private enum CodingKeys: String, CodingKey {
    case compliances = "data"
  }
}

struct CompliancResponseModel: Decodable {
  let compliance: ComplianceModel

  private enum CodingKeys: String, CodingKey {
    case compliance = "data"
  }
}