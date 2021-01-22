//
//  ProjectInfoView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22.01.21.
//

import SwiftUI

struct ProjectInfoView: View {
    @Binding var document: ProjectManagerDocument
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                if document.project.projectInfo.image == nil {
                    Image(systemName: "doc.circle")
                        .font(.system(size: 200))
                        .frame(width: 200.0, height: 225.0, alignment: .center)
                        .padding(.top)
                }
                else {
                    #if os(macOS)
                    let image = NSImage(data: document.project.projectInfo.image ?? Data())
                    Image(nsImage: image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 225.0, height: 225.0, alignment: .center)
                        .clipShape(Circle())
                        .padding(.vertical)
                    #else
                    let image = UIImage(data: document.project.projectInfo.image ?? Data())
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 225.0, height: 225.0, alignment: .center)
                        .clipShape(Circle())
                        .padding(.vertical)
                    #endif
                }
                
                #if os(macOS)
                Button("Select Project Image") {
                    let openPanel = NSOpenPanel()
                    openPanel.prompt = "Select Project Image"
                    openPanel.allowsMultipleSelection = false
                    openPanel.canChooseDirectories = false
                    openPanel.canCreateDirectories = false
                    openPanel.canChooseFiles = true
                    openPanel.worksWhenModal = true
                    openPanel.allowedFileTypes = ["png", "jpg", "jpeg", "gif"]
                    openPanel.begin { (result) -> Void in
                        do {
                            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                                let url = openPanel.url!
                                document.project.projectInfo.image = try Data(contentsOf: url)
                            }
                        }
                        catch {
                            print("The selected image could not be loaded: \(openPanel.url!.path)")
                        }
                    }
                }
                .padding(.bottom)
                #else
                Button("Select Project Image") {
                    self.showImagePicker.toggle()
                }
                .padding(.bottom)
                #endif
            
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
            }
            .frame(minWidth: 200, maxWidth: .infinity)
        }
        .notMacOS() {
            $0.sheet(isPresented: $showImagePicker) {
                #if !os(macOS)
                ImagePicker(sourceType: .photoLibrary) { image in
                    document.project.projectInfo.image = image.jpegData(compressionQuality: 0)
                }
                #endif
            }
        }
    }
}

struct ProjectInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoView(document: .constant(createMockProjectDocument()))
    }
}
