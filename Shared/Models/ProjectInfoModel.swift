//
//  ProjectInfoModel.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import Foundation

struct ProjectInfo: Codable {
    var name: String
    var description: String
    var startDate: Date?
    var endDate: Date?
}
