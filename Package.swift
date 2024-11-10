// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ColorfulX",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .macCatalyst(.v14),
        .tvOS(.v14),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "ColorfulX", targets: ["ColorfulX"]),
    ],
    dependencies: [
        .package(url: "https://github.com/abcdefghijklmnopqrstuvwxyzaao/ColorVector.git", from: "0.0.1"),
        .package(url: "https://github.com/abcdefghijklmnopqrstuvwxyzaao/SpringInterpolation.git", from: "0.0.1"),
        .package(url: "https://github.com/abcdefghijklmnopqrstuvwxyzaao/MSDisplayLink.git", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "ColorfulX",
            dependencies: [
                "ColorVector",
                "SpringInterpolation",
                "MSDisplayLink",
            ]
        ),
    ]
)
