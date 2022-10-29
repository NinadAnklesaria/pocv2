// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "crack_station",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v5),
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "crack_station",
            targets: ["crack_station"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "crack_station",
            dependencies: [],
            resources: [
		        .process("Resources"),
		        .process("data.json")
	        ]
        ),
        .testTarget(
            name: "crack_stationTests",
            dependencies: ["crack_station"]),
    ]
)