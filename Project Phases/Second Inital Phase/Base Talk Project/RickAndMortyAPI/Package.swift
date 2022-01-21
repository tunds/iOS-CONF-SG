// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RickAndMortyAPI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Helpers",
            targets: ["Helpers"]),
        .library(
            name: "Models",
            targets: ["Models"]),
        .library(
            name: "Mapper",
            targets: ["Mapper"]),
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "Characters",
            targets: ["Characters"]),
        .library(
            name: "Settings",
            targets: ["Settings"]),
        .library(
            name: "Form",
            targets: ["Form"]),
        .library(
            name: "RegexValidator",
            targets: ["RegexValidator"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Helpers",
            dependencies: []),
        .target(
            name: "Models",
            dependencies: []),
        .target(
            name: "Mapper",
            dependencies: [
                "Models"
            ]),
        .target(
            name: "Networking",
            dependencies: []),
        .target(
            name: "Characters",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                "Networking",
                "Mapper",
                "Helpers"
            ]),
        .target(
            name: "Settings",
            dependencies: [
                "Helpers",
                "Form"
            ]),
        .target(
            name: "Form",
            dependencies: [
                "RegexValidator"
            ]),
        .target(
            name: "RegexValidator",
            dependencies: [])
    ]
)
