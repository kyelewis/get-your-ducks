import Vapor
import Theo


enum AppError: Error {
    case unknownError(String)
}

func protectedRoutes(_ app: RoutesBuilder) throws {

    app.get("me") { req async -> String in
        do {
            return try req.auth.require(User.self).id
        } catch (let error) {
            print(error)
            return "error"
        }
    }

    app.post("task") { req async -> String in

        do {

            let userId = try req.auth.require(User.self).id

            let client = try await getClient()

        // @todo do properly with a decoder
            let taskTitle: String? = req.query["title"] 

        // @todo learn swift params properly
           try await createTask(client: client, userId: userId, title: taskTitle!)

        return "ok"
        } catch(let error) {
            print(error)
            return "error"
        }
    }

    app.get("tasks") { req async -> String in

        do {
            let userId = try req.auth.require(User.self).id
        let client = try await getClient()

        let taskNames = try await fetchTaskNames(client: client, userId: userId )

        let encodedData = try JSONEncoder().encode(taskNames)

        return String(data: encodedData, encoding: .utf8)!

        } catch (let errorMessage) {
            print(errorMessage)
            return "error";
        }

    }
}

func createTask(client: BoltClient, userId: String, title: String) async throws {
    let query = """
                MATCH(user:User { userId: $userId})
                CREATE (user)-[:WILL_DO]->(task:Task { title: $title }) 
                RETURN task.title as title
                """;

                let result = client.executeCypherSync(query, params: ["userId": userId, "title": title])

                switch(result) {
                    case .success(_):
                        return 
            case .failure(_):
                throw AppError.unknownError("Error")
                }

}

func fetchTaskNames(client: BoltClient, userId: String) async throws -> [String] {

        let query = """
                    MATCH(u:User { userId: $userId })-[:WILL_DO]->(task) 
                    RETURN task.title as title
                    """

        let result = client.executeCypherSync(query, params: ["userId": userId])

        switch(result) {
            case let .success(queryResult):
                return queryResult.rows.map { $0["title"] as! String }
            case let .failure(error):
                throw AppError.unknownError("Error")

    }

}
