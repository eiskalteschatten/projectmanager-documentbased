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
    private let TEST_TXT_NAME = "test.txt"
    private let RESOURCES_DIR = "Resources"
    
    var text: String = ""

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.projectPackage] }

    init(configuration: ReadConfiguration) throws {
        guard let wrappers = configuration.file.fileWrappers
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        let resourcesDirectory = wrappers[RESOURCES_DIR]
        let resourcesFiles = resourcesDirectory?.fileWrappers
        
        if let testTxtFile = resourcesFiles?[TEST_TXT_NAME] {
            guard let data = testTxtFile.regularFileContents,
                let string = String(data: data, encoding: .utf8)
            else {
                throw CocoaError(.fileReadCorruptFile)
            }
            
            text = string
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let rootDirectory = FileWrapper(directoryWithFileWrappers: [:])
        
        let resourcesDirectory = FileWrapper(directoryWithFileWrappers: [:])
        resourcesDirectory.filename = RESOURCES_DIR
        resourcesDirectory.preferredFilename = RESOURCES_DIR
        
        let data = text.data(using: .utf8)!
        let wrapper = FileWrapper(regularFileWithContents: data)
        wrapper.filename = TEST_TXT_NAME
        wrapper.preferredFilename = TEST_TXT_NAME
        
        resourcesDirectory.addFileWrapper(wrapper)
        
        rootDirectory.addFileWrapper(resourcesDirectory)
        
        return rootDirectory
    }
}
