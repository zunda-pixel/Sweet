// swift-tools-version:5.7

import PackageDescription

var package = Package(
  name: "Sweet",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
    .macCatalyst(.v13)
  ],
  products: [
    .library(
      name: "Sweet",
      targets: ["Sweet"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/zunda-pixel/HTTPClient", .upToNextMajor(from: "1.4.2")),
    .package(url: "https://github.com/apple/swift-format", .upToNextMajor(from: "508.0.0")),
    .package(url: "https://github.com/zunda-pixel/OAuth1", .upToNextMajor(from: "1.0.6"))
  ],
  targets: [
    .target(
      name: "Sweet",
      dependencies: [
        .product(name: "HTTPClient", package: "HTTPClient"),
        .product(name: "OAuth1", package: "OAuth1")
      ]),
    .testTarget(
      name: "SweetTests",
      dependencies: ["Sweet"],
      path: "Tests",
      resources: [.process("Resources")]
    )
  ]
)
