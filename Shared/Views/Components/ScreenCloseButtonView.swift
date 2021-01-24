//
//  ScreenCloseButtonView.swift
//  ProjectManager
//
//  Created by Alex Seifert on 24/01/2021.
//

import SwiftUI

struct ScreenCloseButtonView: View {
    @Binding var showScreen: Bool
    
    var body: some View {
        #if os(macOS)
        let fontSize = CGFloat(20.0)
        #else
        let fontSize = CGFloat(25.0)
        #endif
        
        Button(action: {
            self.showScreen = false
        }) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: fontSize))
                .foregroundColor(.gray)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
