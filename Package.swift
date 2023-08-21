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
        .package(url: "https://github.com/wikimedia/wikipedia-ios-data.git", revision: "40b124b17dd325aa2901054778ce19b8939935b2")
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


