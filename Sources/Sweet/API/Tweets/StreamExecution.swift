//
//  StreamExecution.swift
//

import Foundation

final class StreamExecution: NSObject, URLSessionDataDelegate {
  let handler: (Data) -> Void
  let errorHandle: (Error) -> Void

  var task: URLSessionDataTask!

  init(
    request: URLRequest, handler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void
  ) {
    self.handler = handler
    self.errorHandle = errorHandler

    super.init()

    let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    self.task = session.dataTask(with: request)
  }

  func start() {
    task.resume()
  }

  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    handler(data)
  }

  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    guard let error else { return }
    errorHandle(error)
  }
}
