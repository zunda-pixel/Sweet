# Sweet

Twitter API v2 for Swift

<img src="https://img.shields.io/badge/Swift-5.7-orange" alt="Support Swift 5.7" />


<a href="https://github.com/apple/swift-package-manager" alt="HTTPClient on Swift Package Manager" title="HTTPClient on Swift Package Manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>

<img src="https://img.shields.io/badge/platform-iOS 13~%20%7C%20macOS 10.15(Catalina)~%20%7C%20watchOS 13~%20%7C%20tvOS 6~%20%7C%20Linux%20%7C%20Windows-lightgrey" alt="Support Platform for iOS macOS watchOS tvOS Linux Windows" />

## Getting Started

Add the following dependency clause to your Package.swift:

```swift
dependencies: [
  .package(url: "https://github.com/zunda-pixel/Sweet", .upToNextMajor(from: "2.3.10")),
],
```

```swift
.target(
  name: "PenguinKit",
  dependencies: [
    .product(name: "Sweet", package: "Sweet"),
  ]
)
````

## Usage

```swift
let sweet = Sweet(token: .oAuth2user(token: "token"), config: .default)
let response = try await sweet.me()
print(response.user)
```
