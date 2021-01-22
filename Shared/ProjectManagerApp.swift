//
//  ProjectManagerApp.swift
//  Shared
//
//  Created by Alex Seifert on 04/01/2021.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ProjectManagerDocument()) { file in
            ContentView(document: file.$document)
        }
        .commands {
            SidebarCommands()
        }
    }
}
