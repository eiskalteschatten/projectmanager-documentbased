//
//  TasksView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import SwiftUI

struct TasksView: View {
    @Binding var document: ProjectManagerDocument
    @State private var newTaskIndex: Int?
    
    var body: some View {
        List {
            ForEach(document.project.tasks.indices, id: \.self) { index in
                let task = document.project.tasks[index]
                
                HStack {
                    let circle = task.status == Task.TaskStatus.done ? "largecircle.fill.circle" : "circle"
                    
                    Image(systemName: circle)
                        .font(.system(size: 20.0))
                        .foregroundColor(.blue)
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
//                                    self.toggleTaskDone(index: index)
                                }
                        )
                    
                    VStack {
                        TextField("Task", text: $document.project.tasks[index].name)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        TextField("Notes", text: $document.project.tasks[index].notes)
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(.system(size: 12))
                    }
                }
                .padding(.vertical, 5)
            }
            .onDelete(perform: self.confirmDelete)
        }
        .toolbar() {
            ToolbarItem(placement: .automatic) {
                Button(action: self.addTask) {
                    Label("Add Task", systemImage: "plus")
                }
            }
        }
    }
    
    private func addTask() {
        withAnimation {
            let newTask = Task()
            document.project.tasks.append(newTask)
            newTaskIndex = document.project.tasks.count - 1
        }
    }
    
//    private func toggleTaskDone(index: Int) {
//        document.project.tasks[index].status === Task.TaskStatus.done
//            ? document.project.tasks[index].status = Task.TaskStatus.doing
//            : document.project.tasks[index].status = Task.TaskStatus.done
//    }
    
    private func confirmDelete(offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                document.project.tasks.remove(at: offset)
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(document: .constant(createMockProjectDocument()))
    }
}
