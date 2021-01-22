//
//  TasksKanbanView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import SwiftUI

struct TasksKanbanView: View {
    @Binding var document: ProjectManagerDocument
    
    var body: some View {
        Text("Kanban")
    }
}

struct TasksKanbanView_Previews: PreviewProvider {
    static var previews: some View {
        TasksKanbanView(document: .constant(createMockProjectDocument()))
    }
}
