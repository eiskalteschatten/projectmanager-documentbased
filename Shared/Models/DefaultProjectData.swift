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

func getDefaultSettingsData() -> SettingsModel {
    return SettingsModel(showHiddenTasks: false)
}

func getDefaultProjectInfoData() -> ProjectInfo {
    return ProjectInfo(
        name: "",
        description: "",
        hasDates: false
    )
}

func getDefaultProjectData() -> Project {
    return Project(
        state: getDefaultStateData(),
        settings: getDefaultSettingsData(),
        projectInfo: getDefaultProjectInfoData(),
        tasks: []
    )
}
