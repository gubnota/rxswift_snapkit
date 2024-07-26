// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "rxswift_snapkit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "rxswift_snapkit",
            targets: ["rxswift_snapkit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.2.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "rxswift_snapkit",
            dependencies: ["RxSwift", "RxCocoa", "SnapKit"]
        ),
        .testTarget(
            name: "rxswift_snapkitTests",
            dependencies: ["rxswift_snapkit", "XCTest"]
        )
    ]
)