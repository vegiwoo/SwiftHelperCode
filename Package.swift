// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftHelperCode",
    platforms: [.iOS(.v13),.macOS(.v10_15)],
    products: [
        .library( name: "SwiftHelperCode", targets: ["SwiftHelperCode"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SwiftHelperCode", dependencies: []),
        .testTarget( name: "SwiftHelperCodeTests", dependencies: ["SwiftHelperCode"]),
    ]
)
