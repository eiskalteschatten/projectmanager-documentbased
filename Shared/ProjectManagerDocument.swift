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
    private let RESOURCES_DIR = "Resources"
    
    var projectName: String = ""
    var dbQueue: DatabaseWriter?

    init(projectName: String = "Hello, world!") {
        self.projectName = projectName
    }

    static var readableContentTypes: [UTType] { [.projectPackage] }

    init(configuration: ReadConfiguration) throws {
        guard let wrappers = configuration.file.fileWrappers
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        let resourcesDirectory = wrappers[RESOURCES_DIR]
        let resourcesFiles = resourcesDirectory?.fileWrappers
        
        if let dbFile = resourcesFiles?[DB_NAME] {
            do {
                guard let dbFilename = dbFile.filename else {
                    throw CocoaError(.fileReadCorruptFile)
                }
                
                self.dbQueue = try DatabaseQueue(path: dbFilename)
                
                try self.dbQueue!.read { db in
                    let projectInfo = try ProjectInfo.fetchOne(db)!
                    self.projectName = projectInfo.name
                }
            }
            catch let error {
                print(error.localizedDescription)
                throw CocoaError(.fileReadCorruptFile)
            }
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let rootDirectory = FileWrapper(directoryWithFileWrappers: [:])
        
        let resourcesDirectory = FileWrapper(directoryWithFileWrappers: [:])
        resourcesDirectory.filename = RESOURCES_DIR
        resourcesDirectory.preferredFilename = RESOURCES_DIR
        
        if configuration.existingFile == nil {
            do {
                let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(DB_NAME)
                let _ = try DatabaseQueue(path: url.absoluteString)
                
                let dbWrapper = try FileWrapper(url: url)
                dbWrapper.filename = DB_NAME
                dbWrapper.preferredFilename = DB_NAME
                
                resourcesDirectory.addFileWrapper(dbWrapper)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
            
        rootDirectory.addFileWrapper(resourcesDirectory)
        return rootDirectory
    }
}
