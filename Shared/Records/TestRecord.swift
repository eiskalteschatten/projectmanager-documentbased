//
//  TestRecord.swift
//  ProjectManager (iOS)
//
//  Created by Alex Seifert on 04/01/2021.
//

import GRDB

class Test: Record {
    var id: Int64?
    var text: String
    
    init(id: Int64?, text: String) {
        self.id = id
        self.text = text
        super.init()
    }
    
    override class var databaseTableName: String { "test" }
    
    enum Columns: String, ColumnExpression {
        case id, text
    }
    
    /// Creates a record from a database row
    required init(row: Row) {
        id = row[Columns.id]
        text = row[Columns.text]
        super.init(row: row)
    }
    
    /// The values persisted in the database
    override func encode(to container: inout PersistenceContainer) {
        container[Columns.id] = id
        container[Columns.text] = text
    }
    
    /// Update record ID after a successful insertion
    override func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
