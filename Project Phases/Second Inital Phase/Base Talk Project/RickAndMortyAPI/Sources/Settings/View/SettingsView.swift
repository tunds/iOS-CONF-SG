//
//  SettingsView.swift
//  Base Talk Project
//
//  Created by Tunde on 11/12/2021.
//

import SwiftUI
import Helpers
import Form

public struct SettingsView: View {
    
    public init() {}
    
    public var body: some View {
        Form {
            contactSection
            aboutSection
        }
        .embedInNavigationView(with: "Settings")
    }
}

private extension SettingsView {
    
    var contactSection: some View {
        Section(header: Text("Contact")) {
            
            NavigationLink {
                ContactFormView()
            } label: {
                Label("Report a bug", systemImage: "ladybug")
            }
            Label("Email us", systemImage: "envelope")
        }
        .symbolVariant(.fill)
    }
    
    var aboutSection: some View {
        Section(header: Text("About")) {
            Label("Follow me on Twitter **@tundsdev**", systemImage: "link")
            Label("Subscribe to my YT channel **tundsdev**", systemImage: "link")
            Label("Meet the developer", systemImage: "person")
                .symbolVariant(.fill)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
