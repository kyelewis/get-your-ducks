import Vapor  // Environment
import Theo  // BoltClient

func getClient() async throws -> BoltClient {

    let client = try BoltClient(
     hostname: Environment.get("BOLT_HOSTNAME") ?? "localhost",
     port: 7687,
     username: Environment.get("BOLT_USERNAME") ?? "neo4j",
     password: Environment.get("BOLT_PASSWORD") ?? "password",
     encrypted: true )

    client.connectSync()
    return client;

}
