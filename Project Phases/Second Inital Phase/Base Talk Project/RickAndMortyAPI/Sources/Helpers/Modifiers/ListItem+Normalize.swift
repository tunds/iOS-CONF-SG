//
//  ListItem+Normalize.swift
//  Base Talk Project
//
//  Created by Tunde on 28/11/2021.
//

import Foundation
import SwiftUI

struct ListItemNormalize: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
    }
}

public extension View {
    
    func normalizeListItem() -> some View {
        self.modifier(ListItemNormalize())
    }
}
