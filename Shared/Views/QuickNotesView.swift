//
//  QuickNotesView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 23/01/2021.
//

import SwiftUI

struct QuickNotesView: View {
    @Binding var document: ProjectManagerDocument
    
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

                            Divider()

                            Button(action: { self.deleteNote(offsets: [index]) }) {
                                Text("Delete Note")
                                Image(systemName: "trash")
                            }
                        }
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
    @State private var showEditNote: Bool = false
    
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
        .sheet(isPresented: self.$showEditNote) {
            QuickNoteEditView(quickNote: self.$quickNote, showEditNote: self.$showEditNote)
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    self.showEditNote.toggle()
                }
        )
    }
}

fileprivate struct QuickNoteEditView: View {
    @Binding var quickNote: QuickNote
    @Binding var showEditNote: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                TextField("Note Name", text: self.$quickNote.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Spacer()
                QuickNoteEditCloseButtonView(showEditNote: $showEditNote)
            }
            
            TextEditor(text: self.$quickNote.content)
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

#if os(macOS)
fileprivate extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
        }
    }
}
#endif

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
