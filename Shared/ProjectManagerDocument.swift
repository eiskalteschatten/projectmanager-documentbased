//
//  ProjectManagerDocument.swift
//  Shared
//
//  Created by Alex Seifert on 04/01/2021.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var projectData: UTType {
        UTType(importedAs: "com.alexseifert.projectManagerProject")
    }
}

struct ProjectManagerDocument: FileDocument {
    var project: Project

    init(name: String = "", description: String = "") {
        self.project = Project(name: name, description: description)
    }

    static var readableContentTypes: [UTType] { [.projectData] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
          throw CocoaError(.fileReadCorruptFile)
        }
        self.project = try JSONDecoder().decode(Project.self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(self.project)
        return .init(regularFileWithContents: data)
    }
}
