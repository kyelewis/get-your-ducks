// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "app",
    products: [
        .executable(name: "Run", targets: ["Run"]),
        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/Neo4j-Swift/Neo4j-Swift.git", from: "5.0.0")
    ],
    targets: [
        .executableTarget(name: "Run", dependencies: ["App"]),
        .target(name: "App", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Theo", package: "Neo4j-Swift")])
    ]
)
