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

func createMockProjectDocument() -> ProjectManagerDocument {
    return ProjectManagerDocument(
        projectInfo: createMockProjectInfo()
    )
}
