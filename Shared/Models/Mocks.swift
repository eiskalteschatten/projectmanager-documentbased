//
//  Mocks.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22.01.21.
//

import Foundation

func createMockStateData() -> StateModel {
    return StateModel(screen: ProjectScreen.projectInfo.rawValue)
}

func createMockTasks() -> [Task] {
    var yesterday: Date {
        var components = DateComponents()
        components.day = -1
        return Calendar.current.date(byAdding: components, to: Date())!
    }
    
    var oneDayFromNow: Date {
        var components = DateComponents()
        components.day = 1
        return Calendar.current.date(byAdding: components, to: Date())!
    }
    
    return [
        Task(
            name: "Task 1",
            notes: "Task notes",
            status: .todo,
            dueDate: oneDayFromNow
        ),
        Task(
            name: "Task 2",
            notes: "More task notes",
            status: .doing,
            dueDate: Date()
        ),
        Task(
            name: "Task 3",
            notes: "More task notes",
            status: .done,
            dueDate: yesterday
        )
    ]
}

func createMockProjectInfo() -> ProjectInfo {
    var oneMonthFromNow: Date {
        var components = DateComponents()
        components.month = 1
        return Calendar.current.date(byAdding: components, to: Date())!
    }
    
    return ProjectInfo(
        name: "Test Project",
        description: "Test description",
        hasDates: true,
        startDate: Date(),
        endDate: oneMonthFromNow
    )
}

func createMockProject() -> Project {
    return Project(
        state: createMockStateData(),
        projectInfo: createMockProjectInfo(),
        tasks: createMockTasks()
    )
}

func createMockProjectDocument() -> ProjectManagerDocument {
    return ProjectManagerDocument(
        project: createMockProject()
    )
}
