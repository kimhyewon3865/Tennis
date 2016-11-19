import Vapor
import VaporMySQL

// MARK: - Database

do {
    let driver = try MySQLDriver(
        host: "127.0.0.1",
        user: "root",
        password: "dltmf1995",
        database: "tennis_development",
        port: 3306,
        flag: 0,
        encoding: "utf8"
    )
    Database.default = Database(driver)
} catch {
    print("Could not initialize driver: \(error)")
}

let drop = Droplet(
    database: Database.default,
    preparations: [Post.self]
)

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.resource("posts", PostController())

drop.run()
