//
//  ProjectInfoModel.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import Foundation

struct ProjectInfo: Codable {
    var image: Data?
    var name: String
    var description: String
    var hasDates: Bool
    var startDate: Date?
    var endDate: Date?
}
