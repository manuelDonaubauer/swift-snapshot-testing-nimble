// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SnapshotTesting_Nimble",
     platforms: [
        .iOS(.v11),
        .macOS(.v10_10),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "SnapshotTesting_Nimble",
            targets: ["SnapshotTesting_Nimble"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0"),
        .package(url: "https://github.com/Quick/Quick.git", from: "5.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.1.0")
    ],
    targets: [
        .target(
            name: "SnapshotTesting_Nimble",
            dependencies: [ 
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                "Quick", 
                "Nimble",
                "SnapshotTesting_NimbleObjc"
            ],
            exclude: ["../../Example"]
        ),
        .target(
            name: "SnapshotTesting_NimbleObjc",
            dependencies: ["Quick"]
        )
    ]
)
