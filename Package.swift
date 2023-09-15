// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Components",
            targets: ["Components"]),
    ],
    dependencies: [
        .package(url: "https://github.com/wikimedia/wikipedia-ios-data.git", revision: "f314e2d996d5f5f5e4fcd5f9a04fe5dcf8de821c")
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


