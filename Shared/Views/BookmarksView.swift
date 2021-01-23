//
//  BookmarksView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 23/01/2021.
//

import SwiftUI

struct BookmarksView: View {
    @Binding var document: ProjectManagerDocument
    @State private var selection: Int?
    
    var body: some View {
        List(selection: $selection) {
            ForEach(document.project.bookmarks?.indices ?? 0..<0, id: \.self) { index in
                let bookmark = Binding<Bookmark>(
                    get: { self.document.project.bookmarks![index] },
                    set: { self.document.project.bookmarks![index] = $0 }
                )
                
                BookmarksListItemView(
                    bookmark: bookmark,
                    index: index
                )
                .padding(.vertical, 5)
            }
            .onDelete(perform: self.deleteBookmark)
        }
        .toolbar() {
            #if os(macOS)
            let placement = ToolbarItemPlacement.automatic
            #else
            let placement = ToolbarItemPlacement.navigationBarTrailing
            #endif
            
            ToolbarItem(placement: placement) {
                Button(action: self.addBookmark) {
                    Label("Add Bookmark", systemImage: "plus")
                        .font(.system(size: 22.0))
                }
            }
        }
        .navigationTitle("Bookmarks")
    }
    
    private func addBookmark() {
        withAnimation {
            if self.document.project.bookmarks == nil {
                self.document.project.bookmarks = []
            }
            
            let newBookmark = Bookmark()
            self.document.project.bookmarks?.append(newBookmark)
        }
    }
    
    private func deleteBookmark(offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                self.document.project.bookmarks?.remove(at: offset)
            }
        }
    }
}

fileprivate struct BookmarksListItemView: View {
    @Binding var bookmark: Bookmark
    var index: Int
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("Name", text: self.$bookmark.name)
                .textFieldStyle(PlainTextFieldStyle())

            TextField("URL", text: self.$bookmark.url)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(.vertical, 5)
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView(document: .constant(createMockProjectDocument()))
    }
}
