//
//  GlobalExtensions.swift
//  ProjectManager
//
//  Created by Alex Seifert on 22/01/2021.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
          transform(self)
        }
        else {
          self
        }
    }
    
    @ViewBuilder
    func `macOS`<Transform: View>(transform: (Self) -> Transform) -> some View {
        #if os(macOS)
        transform(self)
        #else
        self
        #endif
    }
    
    @ViewBuilder
    func `notMacOS`<Transform: View>(transform: (Self) -> Transform) -> some View {
        #if !os(macOS)
        transform(self)
        #else
        self
        #endif
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
