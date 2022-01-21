//
//  Navigation+View.swift
//  Base Talk Project
//
//  Created by Tunde on 28/11/2021.
//

import Foundation
import SwiftUI

public extension View {
    
    func embedInNavigationView(with title: String = "") -> some View {
        NavigationView { self.navigationTitle(title) }
    }
    
    func navigate<Destination: View>(to destination: Destination) -> some View {
        self.overlay(NavigationLink(destination: destination) { EmptyView()}.opacity(0))
    }
}
