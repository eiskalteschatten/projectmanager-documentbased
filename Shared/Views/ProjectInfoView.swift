//
//  ProjectInfoView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22.01.21.
//

import SwiftUI

struct ProjectInfoView: View {
    @Binding var document: ProjectManagerDocument
    
    var body: some View {
        VStack {
            TextField("Project Name", text: $document.project.name)
                .frame(maxWidth: 300)
            
            TextField("Project Description", text: $document.project.description)
                .frame(maxWidth: 300)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct ProjectInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoView(document: .constant(createMockProjectDocument()))
    }
}
