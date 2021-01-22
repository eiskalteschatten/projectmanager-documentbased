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
        ScrollView {
            VStack {
                if document.project.projectInfo.image == nil {
                    Image(systemName: "doc.circle")
                        .font(.system(size: 200))
                        .frame(width: 250.0, height: 250.0, alignment: .center)
                }
                else {
                    Image(systemName: "doc.circle")
        //                .resizeable()
        //                .aspectRatio(contentMode: .fill)
                        .frame(width: 250.0, height: 250.0, alignment: .center)
                        .clipShape(Circle())
                }
            
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Project Name", text: $document.project.projectInfo.name)
                        .notMacOS() {
                            $0.textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    
                    TextField("Project Description", text: $document.project.projectInfo.description)
                        .notMacOS() {
                            $0.textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    
                    Divider()
                        .padding(.vertical, 10)
                
                    Toggle(isOn: $document.project.projectInfo.hasDates) {
                        Text("Use start and end dates")
                    }

                    if document.project.projectInfo.hasDates {
                        Group {
                            #if os(macOS)
                            Text("Start Date:")
                            #endif
                            
                            DatePicker(
                                "Start Date:",
                                selection: Binding<Date>(
                                    get: {document.project.projectInfo.startDate ?? Date()},
                                    set: {document.project.projectInfo.startDate = $0}
                                ),
                                displayedComponents: [.date]
                            )
                            .macOS() {
                                $0.labelsHidden()
                            }
                        
                            #if os(macOS)
                            Text("End Date:")
                            #endif
                            
                            DatePicker(
                                "End Date:",
                                selection: Binding<Date>(
                                    get: {document.project.projectInfo.endDate ?? Date()},
                                    set: {document.project.projectInfo.endDate = $0}
                                ),
                                displayedComponents: [.date]
                            )
                            .macOS() {
                                $0.labelsHidden()
                            }
                        }
                        .opacity(document.project.projectInfo.hasDates ? 1 : 0)
                        .animation(.easeInOut)
                    }
                }
                .frame(minWidth: 0, maxWidth: 400, minHeight: 0, maxHeight: .infinity)
                .padding(.bottom)
            }.frame(minWidth: 200, maxWidth: .infinity)
        }
    }
}

struct ProjectInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoView(document: .constant(createMockProjectDocument()))
    }
}
