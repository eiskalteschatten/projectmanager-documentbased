//
//  TaskModel.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import Foundation

struct Task: Codable, Identifiable {
    enum TaskStatus: Int, Codable {
        case todo, done
    }
    
    var id = UUID()
    var name: String = ""
    var notes: String = ""
    var status: TaskStatus = .todo
    var hasDueDate: Bool = false
    var dueDate: Date?
}
