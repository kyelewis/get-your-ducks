import Vapor

struct User: Authenticatable {
    var id: String
}

struct UserAuthenticator: AsyncBearerAuthenticator {
    func authenticate(
        bearer: BearerAuthorization,
        for request: Request
    ) async throws {
        request.auth.login(User(id: bearer.token))
    }
}

public func configure(_ app: Application) throws {

    app.http.server.configuration.port = 8000;

    let cors = CORSMiddleware(configuration: CORSMiddleware.Configuration(
      allowedOrigin: .all,
      allowedMethods: [.GET],
      allowedHeaders: [.accept, .authorization, .contentType]
    )
    )
    app.middleware.use(cors, at: .beginning)

    let fileMiddleware = FileMiddleware(
        publicDirectory: app.directory.publicDirectory
    )
    app.middleware.use(fileMiddleware)

    let protected = app.grouped(UserAuthenticator())

    try protectedRoutes(protected)

}
