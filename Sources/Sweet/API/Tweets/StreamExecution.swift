//
//  StreamExecution.swift
//

import Foundation

class StreamExecution: NSObject, URLSessionDataDelegate {
  let handler: (Data) -> Void

  var task: URLSessionDataTask!

  init(request: URLRequest, handler: @escaping (Data) -> Void) {
    self.handler = handler

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
}
