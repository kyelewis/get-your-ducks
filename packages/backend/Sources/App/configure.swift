import Vapor

public func configure(_ app: Application) throws {

    let cors = CORSMiddleware(configuration: CORSMiddleware.Configuration(
      allowedOrigin: .all,
      allowedMethods: [.GET],
      allowedHeaders: [.accept, .authorization, .contentType]
    )
    )

    app.middleware.use(cors, at: .beginning)
    try routes(app)

}
