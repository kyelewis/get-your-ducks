import Vapor
import Theo

enum AppError: Error {
    case unknownError(String)
}

func routes(_ app: Application) throws {
    app.get("name") { req async -> String in

        do {
        let client = try await getClient()

        let blogTitles = try await fetchBlogTitles(client: client)

        let encodedData = try JSONEncoder().encode(blogTitles)

        return String(data: encodedData, encoding: .utf8)!

        } catch (let errorMessage) {
            print(errorMessage)
            return "error";
        }

    }
}

func fetchBlogTitles(client: BoltClient) async throws -> [String] {

    return try await withCheckedThrowingContinuation { continuation in

        client.nodesWith(labels: ["Blog"]) { result in
            switch result {
                case .success(let nodes):
                    continuation.resume(returning: nodes.map { $0.properties["title"] as! String })
                case .failure(let error):
                    continuation.resume(throwing: error)
            }
        }

    }

}
