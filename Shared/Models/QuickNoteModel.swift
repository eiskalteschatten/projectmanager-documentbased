//
//  QuickNoteModel.swift
//  ProjectManager
//
//  Created by Alex Seifert on 23/01/2021.
//

import Foundation

struct QuickNote: Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var content: String = ""
    var pinned: Bool = false
}
