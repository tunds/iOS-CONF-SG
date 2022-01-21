//
//  List+Normalize.swift
//  Base Talk Project
//
//  Created by Tunde on 28/11/2021.
//

import Foundation
import SwiftUI

struct ListNormalize: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
    }
}

public extension View {
    
    func normalizeList() -> some View {
        self.modifier(ListNormalize())
    }
}
