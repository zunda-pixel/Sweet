//
//  BatchCompliances.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  public func fetchCompliances(type: JobType, status: ComplianceStatus? = nil) async throws -> [ComplianceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs
    
    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs")!
    
    let queries: [String: String?] = [
      "type": type.rawValue,
      "status": status?.rawValue,
    ].filter { $0.value != nil && $0.value != ""}
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers, queries: queries)
    
    if let response = try? JSONDecoder().decode(CompliancesResponse.self, from: data) {
      return response.compliances
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func fetchCompliance(jobID: String) async throws -> ComplianceModel {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs/\(jobID)")!
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await session.get(url: url, headers: headers)
    
    if let response = try? JSONDecoder().decode(ComplianceResponse.self, from: data) {
      return response.compliance
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
  
  public func createCompliance(type: JobType, name: String? = nil, resumable: Bool? = nil) async throws -> ComplianceModel {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/post-compliance-jobs
    
    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs")!
    
    struct JobModel: Encodable {
      public let type: JobType
      public let name: String?
      public let resumable: Bool?
      
      private enum CodingKeys: String, CodingKey {
        case type
        case name
        case resumable
      }
      
      public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type.rawValue, forKey: .type)
        if let name = name { try container.encode(name, forKey: .name) }
        if let resumable = resumable { try container.encode(resumable, forKey: .resumable) }
      }
    }
    
    let jobModel: JobModel = .init(type: type, name: name, resumable: resumable)
    
    let body = try JSONEncoder().encode(jobModel)
    
    let headers = getBearerHeaders(type: .App)
    
    let (data, urlResponse) = try await session.post(url: url, body: body, headers: headers)
    
    if let response = try? JSONDecoder().decode(ComplianceResponse.self, from: data) {
      return response.compliance
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknown(data: data, response: urlResponse)
  }
}
