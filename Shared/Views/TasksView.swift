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
    @State private var selection: Int?
    
    var body: some View {
        List(selection: $selection) {
            ForEach(document.project.tasks.indices, id: \.self) { index in
                let task = document.project.tasks[index]
                
                HStack {
                    let taskDone = task.status == Task.TaskStatus.done
                    let circle = taskDone ? "largecircle.fill.circle" : "circle"
                    
                    #if os(macOS)
                    let fontSize = CGFloat(20.0)
                    #else
                    let fontSize = CGFloat(25.0)
                    #endif
                    
                    Image(systemName: circle)
                        .font(.system(size: fontSize))
                        .foregroundColor(taskDone ? .blue : .gray)
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
//                                    self.toggleTaskDone(index: index)
                                }
                        )
                    
                    VStack {
                        TextField("Task", text: $document.project.tasks[index].name, onEditingChanged: { (editingChanged) in
                            self.selection = editingChanged ? index : nil
                        })
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        
                        TextField("Notes", text: $document.project.tasks[index].notes, onEditingChanged: { (editingChanged) in
                            self.selection = editingChanged ? index : nil
                        })
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(.system(size: 12))
                            .opacity(0.8)
                    }
                    
                    Spacer()
                    
                    if self.selection == index {
                        #if os(macOS)
                        let fontSize = CGFloat(17.0)
                        #else
                        let fontSize = CGFloat(22.0)
                        #endif
                        
                        Image(systemName: "info.circle")
                            .font(.system(size: fontSize))
                            .foregroundColor(.white)
                            .gesture(
                                TapGesture()
                                    .onEnded { _ in
                                        print("Open!")
                                    }
                            )
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
        .navigationTitle("Tasks")
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
