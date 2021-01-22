//
//  ProjectModel.swift
//  ProjectManager
//
//  Created by Alex Seifert on 21/01/2021.
//

import Foundation

struct Project: Codable {
    var state: StateModel
    var projectInfo: ProjectInfo
    var tasks: [Task]
}
