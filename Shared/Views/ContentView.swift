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
        NavigationViewWrapper(projectName: document.project.name) {
            NavigationLink(
                destination: ProjectInfoView(document: $document),
                tag: ProjectScreen.projectInfo,
                selection: $navSelection,
                label: {
                    Label("Project Info", systemImage: "info.circle")
                }
            )
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

fileprivate struct NavigationViewWrapper<Content>: View where Content: View {
    let content: () -> Content
    var projectName: String = "ProjectManager"

    init(projectName: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.projectName = projectName != "" ? projectName : self.projectName
    }

    var body: some View {
        #if os(macOS)
        NavigationView {
            List {
                content()
            }
            .listStyle(SidebarListStyle())
        }
        #else
        NavigationView {
            List {
                content()
            }
            .listStyle(SidebarListStyle())
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        for window in UIApplication.shared.windows where window.isKeyWindow {
                            window.rootViewController?.dismiss(animated: true, completion: nil)
                            break
                        }
                    }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                }
            }
            .navigationTitle(self.projectName)
        }
        .navigationBarHidden(true)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(createMockProjectDocument()))
    }
}
