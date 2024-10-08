// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "BarrelAPI",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.99.3"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        
        // Database
        .package(url: "https://github.com/vapor/fluent.git", from: "4.9.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.8.0"),
        
        // JWT
        .package(url: "https://github.com/vapor/jwt.git", from: "4.0.0"),
        
//        // Swagger
        .package(url: "https://github.com/dankinsoid/VaporToOpenAPI.git", from: "4.6.3")
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                
                // Database
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                
                // JWT
                .product(name: "JWT", package: "jwt"),
                
                // Swagger
                .product(name: "VaporToOpenAPI", package: "VaporToOpenAPI"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App"),
                .product(name: "XCTVapor", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("DisableOutwardActorInference"),
    .enableExperimentalFeature("StrictConcurrency"),
] }
