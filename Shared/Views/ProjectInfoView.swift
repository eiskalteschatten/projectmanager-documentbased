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
        VStack(spacing: 15) {
            TextField("Project Name", text: $document.project.projectInfo.name)
                .notMacOS() {
                    $0.textFieldStyle(RoundedBorderTextFieldStyle())
                }
            
            TextField("Project Description", text: $document.project.projectInfo.description)
                .notMacOS() {
                    $0.textFieldStyle(RoundedBorderTextFieldStyle())
                }
            
            Divider()
            
            VStack(alignment: .leading) {
                #if os(macOS)
                Text("Start Date:")
                #endif
                
                DatePicker(
                    "Start Date:",
                    selection: $document.project.projectInfo.startDate,
                    displayedComponents: [.date]
                )
                .macOS() {
                    $0.labelsHidden()
                }
            }
            
            VStack(alignment: .leading) {
                #if os(macOS)
                Text("End Date:")
                #endif
                
                DatePicker(
                    "End Date:",
                    selection: $document.project.projectInfo.endDate,
                    displayedComponents: [.date]
                )
                .macOS() {
                    $0.labelsHidden()
                }
            }
        }
        .frame(minWidth: 0, maxWidth: 400, minHeight: 0, maxHeight: .infinity)
    }
}

struct ProjectInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoView(document: .constant(createMockProjectDocument()))
    }
}
