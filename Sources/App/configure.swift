import Vapor
import Fluent
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    
    guard let host = Environment.get("DATABASE_HOST") else {
        throw Abort(.custom(code: 500, reasonPhrase: "DATABASE_HOST failed"))
    }
        
    guard let port = Int(Environment.get("DATABASE_PORT") ?? "") else {
            throw Abort(.custom(code: 500, reasonPhrase: "DATABASE_PORT failed"))
    }
        
    guard let username = Environment.get("DATABASE_USERNAME") else {
        throw Abort(.custom(code: 500, reasonPhrase: "DATABASE_USERNAME failed"))
    }
        
    guard let password = Environment.get("DATABASE_PASSWORD") else {
        throw Abort(.custom(code: 500, reasonPhrase: "DATABASE_PASSWORD failed"))
    }
        
    guard let name = Environment.get("DATABASE_NAME") else {
        throw Abort(.custom(code: 500, reasonPhrase: "DATABASE_NAME failed"))
    }
        
    app.databases.use(
        .postgres(
            configuration: .init(
                hostname: host,
                port: port,
                username: username,
                password: password,
                database: name,
                tls: .prefer(try .init(configuration: .clientDefault)))
        ),
        as: .psql
    )
    
    // Configure JWT
    app.jwt.signers.use(.hs256(key: "your-secret-key"))
    
    app.migrations.add(CreateUser())
    app.migrations.add(CreateEntry())
    
    try routes(app)
}
