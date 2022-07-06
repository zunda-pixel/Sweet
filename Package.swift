// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var package = Package(
    name: "Sweet",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Sweet",
            targets: ["Sweet"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(url: "https://github.com/zunda-pixel/HTTPClient", .upToNextMajor(from: "1.3.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
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
package.dependencies.append(.package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0"))
package.targets[0].dependencies.append(.product(name: "Crypto", package: "swift-crypto"))
#endif
