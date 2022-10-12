//
//  JobStatus.swift
//

extension Sweet {
  /// Job Status
  public enum JobStatus: String, Sendable {
    case created
    case inProgress = "in_progress"
    case failed
    case complete
    case expired
  }
}
