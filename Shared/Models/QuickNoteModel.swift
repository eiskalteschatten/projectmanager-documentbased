//
//  QuickNoteModel.swift
//  ProjectManager
//
//  Created by Alex Seifert on 23/01/2021.
//

import Foundation
import SwiftUI

struct QuickNote: Codable, Identifiable {
    struct RgboColor: Codable {
        var r: Double
        var g: Double
        var b: Double
        var o: Double
    }
    
    var id = UUID()
    var name: String = ""
    var content: String = ""
    var pinned: Bool = false
    var color: RgboColor = RgboColor(r: 0, g: 0, b: 0, o: 0)
}
