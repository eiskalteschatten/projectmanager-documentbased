//
//  ContentView.swift
//  Shared
//
//  Created by Alex Seifert on 04/01/2021.
//

import SwiftUI

enum ProjectScreen: Int {
    case projectInfo, tasks, bookmarks, quickNotes
}

struct ContentView: View {
    @Binding var document: ProjectManagerDocument
    @State private var screen: ProjectScreen?
    
    init(document: Binding<ProjectManagerDocument>) {
        self._document = document
        self._screen = State(initialValue: ProjectScreen.init(rawValue: document.project.state.screen.wrappedValue))
    }

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
            NavigationLink(
                destination: TasksView(document: $document),
                tag: ProjectScreen.tasks,
                selection: $screen,
                label: {
                    Label("Tasks", systemImage: "checkmark.square")
                }
            )
            NavigationLink(
                destination: BookmarksView(document: $document),
                tag: ProjectScreen.bookmarks,
                selection: $screen,
                label: {
                    Label("Bookmarks", systemImage: "bookmark")
                }
            )
            NavigationLink(
                destination: QuickNotesView(document: $document),
                tag: ProjectScreen.quickNotes,
                selection: $screen,
                label: {
                    Label("Notes", systemImage: "note.text")
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
                            .font(.system(size: 22.0))
                    }
                }
            }
            .navigationTitle(document.project.projectInfo.name != "" ? document.project.projectInfo.name : self.defaultProjectName)
            .onChange(of: self.screen, perform: { _ in
                if self.screen?.rawValue != nil {
                    document.project.state.screen = self.screen?.rawValue ?? ProjectScreen.projectInfo.rawValue
                }
            })
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
