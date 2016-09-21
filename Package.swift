import PackageDescription

let package = Package(
    name: "State",
    exclude: [
        "Tests/StateTests/Models/StateTestModels.xcdatamodeld",
        "Tests/StateTests/Performance",
        "Tests/StateTests/Models/TestMigrationV1.swift"
    ]
)
