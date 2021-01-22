//
//  TasksView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import SwiftUI

struct TasksView: View {
    @Binding var document: ProjectManagerDocument
    
    var body: some View {
        TabView {
            TasksListView(document: $document)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }

            TasksKanbanView(document: $document)
                .tabItem {
                    Image(systemName: "rectangle.split.3x1")
                    Text("Kanban")
                }
        }
        .navigationTitle("Tasks")
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(document: .constant(createMockProjectDocument()))
    }
}
