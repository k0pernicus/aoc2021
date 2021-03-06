// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc2021",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.2"),
        .package(url: "https://github.com/felginep/CartesianProduct.git", from: "0.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "aoc2021",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "CartesianProduct", package: "CartesianProduct")
            ]),
        .testTarget(
            name: "aoc2021Tests",
            dependencies: ["aoc2021"]),
    ],
    swiftLanguageVersions: [.v5]
)
