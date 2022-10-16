//
//  TestCompliancesAPI.swift
//
//
//  Created by zunda on 2022/01/15.
//

import XCTest

@testable import Sweet

final class TestCompliancesAPI: XCTestCase {
  func testFetchComplianceJobs() async throws {
    let complianceJobs = try await Sweet.test.fetchComplianceJobs(type: .tweets)

    print(complianceJobs.first!)
  }

  func testFetchComplianceJob() async throws {
    let jobID = "1579194619895480320"
    let complianceJob = try await Sweet.test.fetchComplianceJob(jobID: jobID)

    print(complianceJob)
  }

  func testCreateComplianceJob() async throws {
    let complianceJob = try await Sweet.test.createComplianceJob(type: .tweets, name: "testJob")

    print(complianceJob)
  }

  func testUploadComplianceData() async throws {
    let url = URL(
      string:
        "https://storage.googleapis.com/twttr-tweet-compliance/1579194619895480320/submission/1468034183536984067_1579194619895480320?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=complianceapi-public-svc-acct%40twttr-compliance-public-prod.iam.gserviceaccount.com%2F20221009%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20221009T193832Z&X-Goog-Expires=900&X-Goog-SignedHeaders=content-type%3Bhost&X-Goog-Signature=a68fc5521b2a9968bc3807a7541c92635e4a3a6996cfd8edbc0a8d9b2b8dfff05fc9ad55a346092659319318ba245eae53d2dd3fddb3798d02dd0c989db965cf61cbb3d8ed473bec40470b8ab8d795a93e2bf1a15d76eb2c30ff85e3b9d80c99bb97df61831916229c1b6b19206df204ba85ebefe4bb93048b5312ec1c2c85651200897debb3b6d5b523494314270ec28aeafbf8b293ba492e9cd958db6c2524854f13aa662e5779c80cf6acc9b31ae3c1094ae1b3638dc0b91d46c8cca3a60f2525fc869d69c901104bf7a55a0cae1f7c73a049905cb19d72c6a96ca581a8f4aa6fd52388ca871a7533344eedab68409a476628c84b1c421e76a99e4e08633a"
    )!

    let tweetIDs = [
      "1537705231160836096",
      "1529225999111835648",
      "1529100586440097792",
      "1546086942969802752",
      "1527957294268710912",
      "1521767287778254848",
    ]

    try await Sweet.uploadComplianceData(uploadURL: url, ids: tweetIDs)
  }

  func testDownloadComplianceData() async throws {
    let url = URL(
      string:
        "https://storage.googleapis.com/twttr-tweet-compliance/1579194619895480320/delivery/1468034183536984067_1579194619895480320?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=complianceapi-public-svc-acct%40twttr-compliance-public-prod.iam.gserviceaccount.com%2F20221009%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20221009T193832Z&X-Goog-Expires=604800&X-Goog-SignedHeaders=host&X-Goog-Signature=4ac7b2d5630681f9d172a2a6a40bfd5f4b1d80ba65ccb821f8bbf89d74841a8de835663a062e3c38af3f3c99ea64e76777279cccd28dd4f8789c87275a254876cbaaf3c92eda9b2688850c05802e3f806517f4aba3b62fae063ffc4e1dfd845791c72ccb329a215ec37076785108e72e9c6d73fad6f53c0376a50a9e298eb87f7ed417230b895d538caab3e8fe551ee475e1a0bdbef924279b0621d172e0d67fde90a1c7efc8ddd3a1f6fbdd29c5f46d322ec226b7f58d75af8647f38f0e1be8372b49f5660ea5bb299db6955aca1a85aac2e5272e485cddfa753a024cf25f3ef49d9c64757940d9343df434bb115f68a2bb2981b5e707fb8ea02532bb6ab074"
    )!

    let compliances = try await Sweet.downloadComplianceData(downloadURL: url)

    print(compliances)
  }
  
  func testStreamUsersCompliance() async throws {
    let stream = TestStream()
    stream.testStreamUsersCompliance()
    let timeoutSeconds: UInt64 = 60 * 3 * 1_000_000_000
    try await Task.sleep(nanoseconds: timeoutSeconds)
  }
  
  func testStreamTweetsCompliance() async throws {
    let stream = TestStream()
    stream.testStreamTweetsCompliance()
    let timeoutSeconds: UInt64 = 60 * 3 * 1_000_000_000
    try await Task.sleep(nanoseconds: timeoutSeconds)
  }
}

private class TestStream: NSObject, URLSessionDataDelegate {
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    print(String(data: data, encoding: .utf8)!)
  }

  func testStreamUsersCompliance() {
    let request = Sweet.test.streamUsersCompliance(partition: 1)
    let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    let task = session.dataTask(with: request)
    task.resume()
  }

  func testStreamTweetsCompliance() {
    let request = Sweet.test.streamTweetsCompliance(partition: 1)
    let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    let task = session.dataTask(with: request)
    task.resume()
  }
}
