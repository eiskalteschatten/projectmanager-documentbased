//
//  Mocks.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22.01.21.
//

import Foundation

func createMockProjectInfo() -> ProjectInfo {
    return ProjectInfo(name: "Test Project", description: "Test description")
}

func createMockProject() -> Project {
    return Project(projectInfo: createMockProjectInfo())
}

func createMockProjectDocument() -> ProjectManagerDocument {
    return ProjectManagerDocument(
        project: createMockProject()
    )
}
