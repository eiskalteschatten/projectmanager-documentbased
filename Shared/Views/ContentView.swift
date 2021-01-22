//
//  ContentView.swift
//  Shared
//
//  Created by Alex Seifert on 04/01/2021.
//

import SwiftUI

enum ProjectScreen: Int {
    case projectInfo
}

struct ContentView: View {
    @Binding var document: ProjectManagerDocument
    @State private var screen: ProjectScreen? = .projectInfo

    var body: some View {
        NavigationViewWrapper(document: $document, screen: $screen) {
            NavigationLink(
                destination: ProjectInfoView(document: $document),
                tag: ProjectScreen.projectInfo,
                selection: $screen,
                label: {
                    Label("Project Info", systemImage: "info.circle")
                }
            )
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .onAppear {
            self.screen = ProjectScreen.init(rawValue: document.project.state.screen)
         }
    }
}

fileprivate struct NavigationViewWrapper<Content>: View where Content: View {
    @Binding var document: ProjectManagerDocument
    @Binding var screen: ProjectScreen?
    
    private var defaultProjectName: String = "ProjectManager"
    let content: () -> Content

    init(document: Binding<ProjectManagerDocument>, screen: Binding<ProjectScreen?>, @ViewBuilder content: @escaping () -> Content) {
        self._document = document
        self._screen = screen
        self.content = content
    }

    var body: some View {
        #if os(macOS)
        NavigationView {
            List {
                content()
            }
            .listStyle(SidebarListStyle())
            .onChange(of: self.screen, perform: { _ in
                document.project.state.screen = self.screen?.rawValue ?? ProjectScreen.projectInfo.rawValue
            })
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
            .navigationTitle(document.project.projectInfo.name != "" ? document.project.projectInfo.name : self.defaultProjectName)
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
