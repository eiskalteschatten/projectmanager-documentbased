//
//  DbMigrations.swift
//  ProjectManager
//
//  Created by Alex Seifert on 04/01/2021.
//

import GRDB

func runDbMigrations(dbQueue: DatabaseWriter) {
    var migrator = DatabaseMigrator()

    migrator.registerMigration("v1") { db in
        try db.create(table: "project_info") { t in
            t.autoIncrementedPrimaryKey("id")
            t.column("name", .text)
            t.column("description", .text)
        }
    }
    
    do {
        try migrator.migrate(dbQueue)
    }
    catch let error {
        print(error.localizedDescription)
    }
}
