//
//  TasksListView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import SwiftUI

struct TasksListView: View {
    @Binding var document: ProjectManagerDocument
    
    var body: some View {
        Text("List")
    }
}

struct TasksListView_Previews: PreviewProvider {
    static var previews: some View {
        TasksListView(document: .constant(createMockProjectDocument()))
    }
}
