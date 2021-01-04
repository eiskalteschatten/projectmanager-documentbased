//
//  ProjectInfoRecord.swift
//  ProjectManager (iOS)
//
//  Created by Alex Seifert on 04/01/2021.
//

import GRDB

class ProjectInfo: Record {
    var id: Int64?
    var name: String
    var description: String
    
    init(id: Int64?, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
        super.init()
    }
    
    override class var databaseTableName: String { "project_info" }
    
    enum Columns: String, ColumnExpression {
        case id, name, description
    }
    
    /// Creates a record from a database row
    required init(row: Row) {
        id = row[Columns.id]
        name = row[Columns.name]
        description = row[Columns.description]
        super.init(row: row)
    }
    
    /// The values persisted in the database
    override func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.name] = name
        container[Columns.description] = description
    }
    
    /// Update record ID after a successful insertion
    override func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
