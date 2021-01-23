//
//  BookmarkModel.swift
//  ProjectManager
//
//  Created by Alex Seifert on 23/01/2021.
//

import Foundation

struct Bookmark: Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var url: String = ""
}
