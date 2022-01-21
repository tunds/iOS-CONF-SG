//
//  FormError.swift
//  Base Talk Project
//
//  Created by Tunde on 12/12/2021.
//

import Foundation

enum FormError {
    case emptyField
}

extension FormError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyField:
            return "Missing Fields"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .emptyField:
            return "Seems like some fields are empty"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .emptyField:
            return "Please fill in this field, you can't leave it empty"
        }
    }
}
