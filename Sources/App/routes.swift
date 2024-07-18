import Vapor

func routes(_ app: Application) throws {
    let protected = app.grouped(JWTMiddleware())
    
    try app
        .grouped("swagger")
        .register(collection: OpenAPIController())
    
    try protected
        .register(collection: EntryController())
    
    try app
        .register(collection: UserController())
}
