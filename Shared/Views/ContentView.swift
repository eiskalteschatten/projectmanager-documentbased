//
//  ContentView.swift
//  Shared
//
//  Created by Alex Seifert on 04/01/2021.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ProjectManagerDocument

    var body: some View {
        TextEditor(text: $document.project.projectInfo.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(ProjectManagerDocument(
            project:
                Project(
                    projectInfo: ProjectInfo(name: "Test Project", description: "Test description")
                )
            )
        ))
    }
}
