//
//  DefaultProjectData.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import Foundation

func getDefaultProjectInfoData() -> ProjectInfo {
    return ProjectInfo(name: "", description: "")
}

func getDefaultProjectData() -> Project {
    return Project(
        projectInfo: getDefaultProjectInfoData()
    )
}
