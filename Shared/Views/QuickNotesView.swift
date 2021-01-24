//
//  QuickNotesView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 23/01/2021.
//

import SwiftUI

struct QuickNotesView: View {
    @Binding var document: ProjectManagerDocument
    @State private var showEditNote: Bool = false
    @State private var editNoteIndex: Int = 0
    
    private let columns = [
        GridItem(.adaptive(minimum: 200), alignment: .leading)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(document.project.quickNotes?.indices ?? 0..<0, id: \.self) { index in
                    let quickNote = Binding<QuickNote>(
                        get: { self.document.project.quickNotes![index] },
                        set: { self.document.project.quickNotes![index] = $0 }
                    )
                    
                    QuickNoteView(quickNote: quickNote)
                        .contextMenu {
                            Button(action: self.addNote) {
                                Text("New Note")
                                Image(systemName: "plus")
                            }
                            
                            Button(action: {
                                self.editNote(index: index)
                            }) {
                                Text("Edit Note")
                                Image(systemName: "pencil")
                            }

                            Divider()

                            Button(action: { self.deleteNote(offsets: [index]) }) {
                                Text("Delete Note")
                                Image(systemName: "trash")
                            }
                        }
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
                                    self.editNote(index: index)
                                }
                        )
                }
            }
            .frame(minWidth: 200, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding()
        .toolbar() {
            #if os(macOS)
            let placement = ToolbarItemPlacement.automatic
            #else
            let placement = ToolbarItemPlacement.navigationBarTrailing
            #endif
            
            ToolbarItem(placement: placement) {
                Button(action: self.addNote) {
                    Label("Add Note", systemImage: "plus")
                        .font(.system(size: 22.0))
                }
            }
        }
        .sheet(isPresented: self.$showEditNote) {
            QuickNoteEditView(document: self.$document, showEditNote: self.$showEditNote, index: self.editNoteIndex)
        }
        .navigationTitle("Notes")
    }
    
    private func addNote() {
        if self.document.project.quickNotes == nil {
            self.document.project.quickNotes = []
        }
        
        let newQuickNote = QuickNote()
        self.document.project.quickNotes?.append(newQuickNote)
        self.editNote(index: document.project.quickNotes!.count - 1)
    }
    
    private func editNote(index: Int) {
        self.editNoteIndex = index
        self.showEditNote = true
    }
    
    private func deleteNote(offsets: IndexSet) {
        for offset in offsets {
            self.document.project.quickNotes?.remove(at: offset)
        }
    }
}

fileprivate struct QuickNoteView: View {
    @Binding var quickNote: QuickNote
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color.yellow)
                .shadow(radius: 2)
        
            VStack(alignment: .leading, spacing: 15) {
                Text(self.quickNote.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(self.quickNote.content)
                    .foregroundColor(.black)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .lineLimit(10)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(10)
        }
    }
}

fileprivate struct QuickNoteEditView: View {
    @Binding var document: ProjectManagerDocument
    @Binding var showEditNote: Bool
    var index: Int
    
    var body: some View {
        let quickNote = Binding<QuickNote>(
            get: { self.document.project.quickNotes![index] },
            set: { self.document.project.quickNotes![index] = $0 }
        )
        
        return VStack(spacing: 15) {
            HStack {
                TextField("Note Name", text: quickNote.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Spacer()
                QuickNoteEditCloseButtonView(showEditNote: $showEditNote)
            }
            
            TextEditor(text: quickNote.content)
                .foregroundColor(.black)
                .accentColor(.black)
                .onAppear {
                    #if !os(macOS)
                    UITextView.appearance().backgroundColor = .clear
                    #endif
                }
        }
        .padding()
        .background(Color.yellow)
        .macOS() { $0.frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: 500) }
    }
}

fileprivate struct QuickNoteEditCloseButtonView: View {
    @Binding var showEditNote: Bool
    
    var body: some View {
        #if os(macOS)
        let fontSize = CGFloat(20.0)
        #else
        let fontSize = CGFloat(25.0)
        #endif
        
        Button(action: {
            self.showEditNote = false
        }) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: fontSize))
                .foregroundColor(.gray)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct QuickNotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuickNotesView(document: .constant(createMockProjectDocument()))
    }
}
