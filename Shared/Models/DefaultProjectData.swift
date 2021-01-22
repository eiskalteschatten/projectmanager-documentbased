//
//  DefaultProjectData.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import Foundation

func getDefaultStateData() -> StateModel {
    return StateModel(screen: ProjectScreen.projectInfo.rawValue)
}

func getDefaultProjectInfoData() -> ProjectInfo {
    return ProjectInfo(name: "", description: "")
}

func getDefaultProjectData() -> Project {
    return Project(
        state: getDefaultStateData(),
        projectInfo: getDefaultProjectInfoData()
    )
}
