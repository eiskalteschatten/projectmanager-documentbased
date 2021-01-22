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

func createMockProjectInfo() -> ProjectInfo {
    return ProjectInfo(
        name: "Test Project",
        description: "Test description",
        startDate: Date(),
        endDate: Date()
    )
}

func createMockProject() -> Project {
    return Project(
        state: createMockStateData(),
        projectInfo: createMockProjectInfo()
    )
}

func createMockProjectDocument() -> ProjectManagerDocument {
    return ProjectManagerDocument(
        project: createMockProject()
    )
}
