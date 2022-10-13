//
//  BatchCompliances.swift
//
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

#if os(Linux) || os(Windows)
  import FoundationNetworking
#endif

extension Sweet {
  public func fetchComplianceJobs(type: JobType, status: JobStatus? = nil) async throws
    -> [ComplianceJobModel]
  {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs

    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs")!

    let queries: [String: String?] = [
      "type": type.rawValue,
      "status": status?.rawValue,
    ].filter { $0.value != nil && $0.value != "" }

    let headers = getBearerHeaders(type: .app)

    let (data, urlResponse) = try await session.data(
      for: .get(url: url, headers: headers, queries: queries))

    if let response = try? JSONDecoder().decode(CompliancesResponse.self, from: data) {
      return response.compliances
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  public func fetchComplianceJob(jobID: String) async throws -> ComplianceJobModel {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/get-compliance-jobs-id

    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs/\(jobID)")!

    let headers = getBearerHeaders(type: .app)

    let (data, urlResponse) = try await session.data(for: .get(url: url, headers: headers))

    if let response = try? JSONDecoder().decode(ComplianceResponse.self, from: data) {
      return response.compliance
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  public func createComplianceJob(type: JobType, name: String? = nil, resumable: Bool = false)
    async throws -> ComplianceJobModel
  {
    // https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/api-reference/post-compliance-jobs

    let url: URL = .init(string: "https://api.twitter.com/2/compliance/jobs")!

    struct JobModel: Encodable, Sendable {
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
        if let name { try container.encode(name, forKey: .name) }
        if let resumable { try container.encode(resumable, forKey: .resumable) }
      }
    }

    let jobModel: JobModel = .init(type: type, name: name, resumable: resumable)

    let body = try JSONEncoder().encode(jobModel)

    let headers = getBearerHeaders(type: .app)

    let (data, urlResponse) = try await session.data(
      for: .post(url: url, body: body, headers: headers))

    if let response = try? JSONDecoder().decode(ComplianceResponse.self, from: data) {
      return response.compliance
    }

    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }

    throw TwitterError.unknown(data: data, response: urlResponse)
  }

  public static func uploadComplianceData(
    uploadURL: URL, ids: [String], config: URLSessionConfiguration = .default
  ) async throws {
    let headers = ["Content-Type": "text/plain"]

    let body = ids.joined(separator: "\n").data(using: .utf8)!

    let (_, response) = try await URLSession(configuration: config).data(
      for: .put(url: uploadURL, body: body, headers: headers))

    let httpResponse = response as! HTTPURLResponse

    if httpResponse.statusCode != 200 {
      throw Sweet.TwitterError.uploadCompliance
    }
  }

  public static func downloadComplianceData(
    downloadURL: URL, config: URLSessionConfiguration = .default
  )
    async throws -> [ComplianceModel]
  {
    let (data, _) = try await URLSession(configuration: config).data(for: .get(url: downloadURL))

    let stringData = String(data: data, encoding: .utf8)!

    let lines = stringData.split(separator: "\n")

    let decoder = JSONDecoder()

    var compliances: [ComplianceModel] = []

    for line in lines {
      let compliance = try decoder.decode(ComplianceModel.self, from: line.data(using: .utf8)!)
      compliances.append(compliance)
    }

    return compliances
  }
}
