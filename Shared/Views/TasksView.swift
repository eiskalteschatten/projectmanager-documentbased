//
//  TasksView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import SwiftUI

struct TasksView: View {
    @Binding var document: ProjectManagerDocument
    @State private var selection: Int?
    @State private var showEditTask: Bool = false
    @State private var editTaskIndex: Int = -1
    
    var body: some View {
        VStack {
            List(selection: $selection) {
                ForEach(document.project.tasks.indices, id: \.self) { index in
                    let task = document.project.tasks[index]
                    
                    if task.status != .done || document.project.settings.showDoneTasks && task.status == .done {
                        HStack {
                            let taskDone = task.status == Task.TaskStatus.done
                            let circle = taskDone ? "largecircle.fill.circle" : "circle"
                            
                            #if os(macOS)
                            let fontSize = CGFloat(20.0)
                            #else
                            let fontSize = CGFloat(25.0)
                            #endif
                            
                            Button(action: {
                                self.toggleTaskDone(index: index)
                                
                                #if !os(macOS)
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                #endif
                            }) {
                                Image(systemName: circle)
                                    .font(.system(size: fontSize))
                                    .foregroundColor(taskDone ? .blue : .gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            VStack {
                                TextField("Task", text: $document.project.tasks[index].name, onEditingChanged: { (editingChanged) in
                                    self.selection = editingChanged ? index : nil
                                })
                                .textFieldStyle(PlainTextFieldStyle())
                                
                                
                                HStack(spacing: 15) {
                                    if document.project.tasks[index].hasDueDate && document.project.tasks[index].dueDate != nil {
                                        Text(getLocalizedShortDateTime(date: document.project.tasks[index].dueDate!))
                                            .font(.system(size: 12))
                                    }
                                    
                                    TextField("Notes", text: $document.project.tasks[index].notes, onEditingChanged: { (editingChanged) in
                                        self.selection = editingChanged ? index : nil
                                    })
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .font(.system(size: 12))
                                }
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
                                                self.editTaskIndex = index
                                                self.showEditTask = true
                                            }
                                    )
                            }
                        }
                        .if(task.status == .done) { $0.opacity(0.5) }
                        .padding(.vertical, 5)
                        .sheet(isPresented: self.$showEditTask) {
                            TasksEditView(document: $document, showEditTask: self.$showEditTask, index: self.$editTaskIndex)
                        }
                    }
                }
                .onDelete(perform: self.confirmDelete)
            }
        }
        .toolbar() {
            ToolbarItem() {
                Button(action: self.addTask) {
                    Label("Add Task", systemImage: "plus")
                        .font(.system(size: 22.0))
                }
            }
            
            ToolbarItem() {
                Menu {
                    Button(action: { document.project.settings.showDoneTasks.toggle() }) {
                        let showHide = document.project.settings.showDoneTasks ? "Hide" : "Show"
                        let icon = document.project.settings.showDoneTasks ? "eye.slash" : "eye"
                        Label("\(showHide) done tasks", systemImage: icon)
                    }
                }
                label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 22.0))
                }
            }
        }
        .navigationTitle("Tasks")
    }
    
    private func addTask() {
        withAnimation {
            let newTask = Task()
            self.document.project.tasks.append(newTask)
            self.editTaskIndex = document.project.tasks.count - 1
            self.showEditTask = true
        }
    }
    
    private func toggleTaskDone(index: Int) {
        self.document.project.tasks[index].status =
            self.document.project.tasks[index].status == .done ? .todo : .done
    }
    
    private func confirmDelete(offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                self.document.project.tasks.remove(at: offset)
            }
        }
    }
}

fileprivate struct TasksEditView: View {
    @Binding var document: ProjectManagerDocument
    @Binding var showEditTask: Bool
    @Binding var index: Int
    
    var body: some View {
        #if os(macOS)
        TasksEditContentView(document: $document, showEditTask: self.$showEditTask, index: self.$index)
            .frame(minWidth: 400, maxWidth: .infinity, maxHeight: 500)
        #else
        NavigationView {
            TasksEditContentView(document: $document, showEditTask: self.$showEditTask, index: self.$index)
                .navigationBarTitle(Text("Edit Task"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showEditTask = false
                }) {
                    TasksEditCloseButtonView(showEditTask: $showEditTask)
                })
        }
        #endif
    }
}

fileprivate struct TasksEditContentView: View {
    @Binding var document: ProjectManagerDocument
    @Binding var showEditTask: Bool
    @Binding var index: Int
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Task", text: $document.project.tasks[index].name)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.system(size: 18.0))
                    
                    #if os(macOS)
                    Spacer()
                    TasksEditCloseButtonView(showEditTask: $showEditTask)
                    #endif
                }
                
                TextField("Notes", text: $document.project.tasks[index].notes)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .padding(.vertical, 10)
            
                Toggle(isOn: $document.project.tasks[index].hasDueDate) {
                    Text("Task is due on day:")
                }
                
                if document.project.tasks[index].hasDueDate {
                    DatePicker(
                        "",
                        selection: Binding<Date>(
                            get: {document.project.tasks[index].dueDate ?? Date()},
                            set: {document.project.tasks[index].dueDate = $0}
                        ),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .labelsHidden()
                }
                
                Spacer()
            }
        }
        .padding()
    }
}

fileprivate struct TasksEditCloseButtonView: View {
    @Binding var showEditTask: Bool
    
    var body: some View {
        #if os(macOS)
        let fontSize = CGFloat(20.0)
        #else
        let fontSize = CGFloat(25.0)
        #endif
        
        Button(action: {
            self.showEditTask = false
        }) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: fontSize))
                .foregroundColor(.gray)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(document: .constant(createMockProjectDocument()))
    }
}
