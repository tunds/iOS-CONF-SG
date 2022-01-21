//
//  AppRouter.swift
//  
//
//  Created by Tunde on 23/12/2021.
//

import Foundation
import SwiftUI
import Characters
import Settings
import Form

public enum Screen {
    case characters
    case settings
    case contactUs
}

public struct AppRouter {
    
    static func get(screen: Screen) -> some View {
        switch screen {
        case .characters:
            return CharactersView()
        case .settings:
            return SettingsView()
        case .contactUs:
            return ContactFormView()
        default:
            return EmptyView()
        }
    }
}
