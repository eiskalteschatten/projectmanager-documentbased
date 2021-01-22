//
//  ContentView.swift
//  Shared
//
//  Created by Alex Seifert on 04/01/2021.
//

import SwiftUI

fileprivate enum ProjectScreen: Int {
    case projectInfo
}

struct ContentView: View {
    @Binding var document: ProjectManagerDocument
    @State private var navSelection: ProjectScreen?

    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: ProjectInfoView(document: $document),
                    tag: ProjectScreen.projectInfo,
                    selection: $navSelection,
                    label: {
                        Label("Project Info", systemImage: "info.circle")
                    }
                )
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(createMockProjectDocument()))
    }
}
