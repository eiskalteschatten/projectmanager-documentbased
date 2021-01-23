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

func createMockSettingsData() -> SettingsModel {
    return SettingsModel(showDoneTasks: true)
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
            hasDueDate: true,
            dueDate: oneDayFromNow
        ),
        Task(
            name: "Task 2",
            notes: "More task notes",
            status: .done,
            hasDueDate: true,
            dueDate: yesterday
        ),
        Task(
            name: "Task 3",
            notes: "I don't have a due date",
            status: .todo,
            hasDueDate: false
        )
    ]
}

func createMockBookmarks() -> [Bookmark] {
    return [
        Bookmark(
            name: "AlexSeifert.com",
            url: "https://www.alexseifert.com"
        ),
        Bookmark(
            name: "History Rhymes",
            url: "https://www.historyrhymes.info"
        )
    ]
}

func createMockQuickNotes() -> [QuickNote] {
    return [
        QuickNote(
            name: "My Note",
            content: "I have a lot notes",
            pinned: true,
            color: QuickNote.RgboColor(r: 101.0, g: 203.0, b: 197.0, o: 1.0)
        ),
        QuickNote(
            name: "This note is pinned",
            content: "Or maybe not many notes at all",
            pinned: false,
            color: QuickNote.RgboColor(r: 250.0, g: 238.0, b: 116.0, o: 1.0)
        ),
        QuickNote(
            name: "This note is pinned",
            content: "",
            pinned: false,
            color: QuickNote.RgboColor(r: 250.0, g: 238.0, b: 116.0, o: 1.0)
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
        settings: createMockSettingsData(),
        projectInfo: createMockProjectInfo(),
        tasks: createMockTasks(),
        bookmarks: createMockBookmarks(),
        quickNotes: createMockQuickNotes()
    )
}

func createMockProjectDocument() -> ProjectManagerDocument {
    return ProjectManagerDocument(
        project: createMockProject()
    )
}
