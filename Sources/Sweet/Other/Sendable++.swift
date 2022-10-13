import Foundation

#if os(Linux) || os(Windows)
  import FoundationNetworking

  extension Data: @unchecked Sendable {}
  extension URLResponse: @unchecked Sendable {}
  extension Date: @unchecked Sendable {}
  extension URL: @unchecked Sendable {}
  extension CGSize: @unchecked Sendable {}
  extension URLSessionConfiguration: @unchecked Sendable {}
#endif
