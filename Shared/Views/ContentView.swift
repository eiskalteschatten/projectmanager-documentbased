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
        VStack {
            TextField("Project Name", text: $document.project.name)
                .frame(maxWidth: 300)
            
            TextField("Project Description", text: $document.project.description)
                .frame(maxWidth: 300)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(ProjectManagerDocument(
            name: "Test Project", description: "Test description"
        )))
    }
}
