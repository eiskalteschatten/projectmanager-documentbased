//
//  ProjectManagerDocument.swift
//  Shared
//
//  Created by Alex Seifert on 04/01/2021.
//

import SwiftUI
import UniformTypeIdentifiers
import GRDB

extension UTType {
    static var projectPackage: UTType {
        UTType(importedAs: "com.alexseifert.projectManagerProject")
    }
}

struct ProjectManagerDocument: FileDocument {
    private let DB_NAME = "db.sqlite"
    
    var text: String

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.projectPackage] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let rootDirectory = FileWrapper(directoryWithFileWrappers: [:])
        
        let resourcesDirectory = FileWrapper(directoryWithFileWrappers: [:])
        resourcesDirectory.filename = "Resources"
        resourcesDirectory.preferredFilename = "Resources"
        
        let data = text.data(using: .utf8)!
        let wrapper = FileWrapper(regularFileWithContents: data)
        wrapper.filename = "test.txt"
        wrapper.preferredFilename = "test.txt"
        
        resourcesDirectory.addFileWrapper(wrapper)
        
        rootDirectory.addFileWrapper(resourcesDirectory)
        
        return rootDirectory
    }
}
