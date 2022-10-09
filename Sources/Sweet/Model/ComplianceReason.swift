//
//  ComplianceReason.swift
//

extension Sweet {
  /// ComplianceReason
  /// https://developer.twitter.com/en/docs/twitter-api/compliance/batch-compliance/introduction
  public enum ComplianceReason: String, Sendable {
    case deleted
    case deactivated
    case scrubGeo = "scrub_geo"
    case protected
    case suspended
  }
}
