//
//  View+Alignment.swift
//  Base Talk Project
//
//  Created by Tunde on 21/12/2021.
//

import Foundation
import SwiftUI

struct ViewCentre: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

extension View {
    
    func centre() -> some View {
        self.modifier(ViewCentre())
    }
}
