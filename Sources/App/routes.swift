import Vapor

func routes(_ app: Application) throws {
    let protected = app.grouped(JWTMiddleware())
    
    app.get { req async in
        "It works!"
    }

    try protected
        .register(collection: EntryController())
    
    try app
        .register(collection: UserController())
}
