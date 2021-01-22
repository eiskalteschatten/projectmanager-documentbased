//
//  TaskModel.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import Foundation

struct Task: Codable {
    enum TaskStatus: Int, Codable {
        case todo, doing, done
    }
    
    var name: String?
    var notes: String?
    var status: TaskStatus = .todo
    var dueDate: Date?
}
