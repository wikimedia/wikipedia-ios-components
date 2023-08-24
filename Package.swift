// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Components",
            targets: ["Components"]),
    ],
    dependencies: [
        .package(url: "https://github.com/wikimedia/wikipedia-ios-data.git", revision: "7ef061ce02de2b78d04512b8df0de297da7662b2")
    ],
    targets: [
        .target(
            name: "Components",
            dependencies: [
                .product(name: "WKData", package: "wikipedia-ios-data"),
                .product(name: "WKDataMocks", package: "wikipedia-ios-data")]),
        .testTarget(
            name: "ComponentsTests",
            dependencies: ["Components"]),
    ]
)


