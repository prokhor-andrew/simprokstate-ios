// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "simprokstate",
    products: [
        .library(
            name: "simprokstate",
            targets: ["simprokstate"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/simprok-dev/simprokmachine-ios.git",
            exact: .init(1, 1, 15)
        )
    ],
    targets: [
        .target(
            name: "simprokstate",
            dependencies: [
                .product(
                    name: "simprokmachine",
                    package: "simprokmachine-ios"
                )
            ]
        )
    ]
)
