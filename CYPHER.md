MATCH(u:User { userId: "3e1937d8-75e3-4e4f-8277-e7c60d55831c"})-[:WILL_DO]->(task) RETURN task.title as title

MATCH(u:User { userId: $userId })
r = (u)-[:WILL_DO]->(t:Task { title: $title }) RETURN t.title as title

