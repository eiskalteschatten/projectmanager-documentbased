//
//  QuickNotesView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 23/01/2021.
//

import SwiftUI

struct QuickNotesView: View {
    @Binding var document: ProjectManagerDocument
    
    private let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyHGrid(rows: rows, spacing: 10) {
                ForEach(document.project.quickNotes?.indices ?? 0..<0, id: \.self) { index in
                    let quickNote = Binding<QuickNote>(
                        get: { self.document.project.quickNotes![index] },
                        set: { self.document.project.quickNotes![index] = $0 }
                    )
                    
                    QuickNoteView(quickNote: quickNote, index: index)
                    .contextMenu {
                        Button(action: self.addNote) {
                            Text("New Note")
                            Image(systemName: "plus")
                        }

                        Divider()

                        Button(action: { self.deleteNote(offsets: [index]) }) {
                            Text("Delete Note")
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
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
        .navigationTitle("Notes")
    }
    
    private func addNote() {
        if self.document.project.quickNotes == nil {
            self.document.project.quickNotes = []
        }
        
        let newQuickNote = QuickNote()
        self.document.project.quickNotes?.append(newQuickNote)
    }
    
    private func deleteNote(offsets: IndexSet) {
        for offset in offsets {
            self.document.project.quickNotes?.remove(at: offset)
        }
    }
}

fileprivate struct QuickNoteView: View {
    @Binding var quickNote: QuickNote
    var index: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
//                .fill(Color(.sRGB, red: quickNote.color.r, green: quickNote.color.g, blue: quickNote.color.b, opacity: quickNote.color.o))
                .fill(Color.yellow)
                .shadow(radius: 2)
        
            VStack(alignment: .leading, spacing: 5) {
                TextField("Name", text: self.$quickNote.name)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 18))

                TextField("Note...", text: self.$quickNote.content)
                    .textFieldStyle(PlainTextFieldStyle())
            }.padding(10)
        }
    }
}

struct QuickNotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuickNotesView(document: .constant(createMockProjectDocument()))
    }
}
