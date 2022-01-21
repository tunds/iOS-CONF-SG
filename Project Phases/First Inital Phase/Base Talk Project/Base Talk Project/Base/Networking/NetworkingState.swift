//
//  NetworkingState.swift
//  Base Talk Project
//
//  Created by Tunde on 21/12/2021.
//

import Foundation

enum NetworkingState<T: Equatable, E: CustomError> {
    case idle
    case loading
    case completed(data: T)
    case failed(error: E)
}

extension NetworkingState: Equatable {
    
    var hasError: Bool {
        guard case .failed = self else {
            return false
        }
        return true
    }
    
    var failureReason: NetworkingError? {
        guard case let .failed(error) = self else {
            return nil
        }
        return error as? NetworkingError
    }
    
    static func == (lhs: NetworkingState<T, E>, rhs: NetworkingState<T, E>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.completed(let lhsType), .completed(let rhsType)):
            return lhsType == rhsType
        case (.failed(let lhsType), .failed(let rhsType)):
            return lhsType == rhsType
        default:
            return false
        }
    }
}
