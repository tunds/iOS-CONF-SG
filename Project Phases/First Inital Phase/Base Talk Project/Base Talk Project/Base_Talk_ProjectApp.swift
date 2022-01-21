//
//  Base_Talk_ProjectApp.swift
//  Base Talk Project
//
//  Created by Tunde on 22/11/2021.
//

import SwiftUI

@main
struct Base_Talk_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                CharactersView()
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Characters")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
    }
}
