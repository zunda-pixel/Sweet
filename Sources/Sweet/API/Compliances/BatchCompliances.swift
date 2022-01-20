//
//  BatchCompliances.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation

extension Sweet {
  func fetchCompliances(type: JobType) async throws -> [ComplianceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs")!
    
    let queries = ["type": type.rawValue]

    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let compliancesResponseModel = try JSONDecoder().decode(CompliancesResponseModel.self, from: data)
    
    return compliancesResponseModel.compliances
  }

  func fetchCompliance(jobID: String) async throws -> ComplianceModel {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs
    
    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs/\(jobID)")!
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
        
    let complianceResponseModel = try JSONDecoder().decode(ComplianceResponseModel.self, from: data)
    
    return complianceResponseModel.compliance
  }

  func createCompliance(type: JobType, name: String? = nil, resumable: Bool? = nil) async throws -> ComplianceModel {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/post-compliance-jobs

    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs")!

    struct JobModel: Encodable {
      let type: JobType
      let name: String?
      let resumable: Bool?
      
      private enum CodingKeys: String, CodingKey {
        case type
        case name
        case resumable
      }
      
      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type.rawValue, forKey: .type)
        if let name = name { try container.encode(name, forKey: .name) }
        if let resumable = resumable { try container.encode(resumable, forKey: .resumable) }
      }
    }

    let jobModel: JobModel = .init(type: type, name: name, resumable: resumable)

    let body = try JSONEncoder().encode(jobModel)
    
    let headers = bearerHeaders
    
    let (data, _) = try await HTTPClient.post(url: url, body: body, headers: headers)
        
    let complianceResponseModel = try JSONDecoder().decode(ComplianceResponseModel.self, from: data)
    
    return complianceResponseModel.compliance
  }
}
