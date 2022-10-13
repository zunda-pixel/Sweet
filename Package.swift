// swift-tools-version:5.7

import PackageDescription

var package = Package(
    name: "Sweet",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "Sweet",
            targets: ["Sweet"]),
    ],
    dependencies: [
      .package(url: "https://github.com/zunda-pixel/HTTPClient", .upToNextMajor(from: "1.3.3")),
      .package(url: "https://github.com/apple/swift-format", branch: "main"),
    ],
    targets: [
        .target(
            name: "Sweet",
            dependencies: [
              .product(name: "HTTPClient", package: "HTTPClient")
            ]),
        .testTarget(
            name: "SweetTests",
            dependencies: ["Sweet"]),
    ]
)

#if os(Linux) || os(Windows)
package.dependencies.append(.package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "2.0.0")))
package.targets[0].dependencies.append(.product(name: "Crypto", package: "swift-crypto"))
#endif
