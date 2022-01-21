//
//  RegexValidator.swift
//  Base Talk Project
//
//  Created by Tunde on 12/12/2021.
//

import Foundation

struct RegexValidator {
    
    enum State {
        case valid
        case invalid(reason: LocalizedError)
    }
    
    struct Config {
        let pattern: String
        let error: LocalizedError
    }
    
    let configs: [Config]
    
    init(configs: [Config]) {
        precondition(!configs.isEmpty,
                     "Passed in an empty configuration for regex validator")
        self.configs = configs
    }
    
    func validate(val: String) -> State {
        for config in configs {
            if doesMatch(val: val, pattern: config.pattern) {
                return .invalid(reason: config.error)
            }
        }
        return .valid
    }
    
    func doesMatch(val: String, pattern: String) -> Bool {
        val.range(of: pattern, options: .regularExpression) != nil
    }
}

extension RegexValidator.State: Equatable {
    
    static func == (lhs: RegexValidator.State, rhs: RegexValidator.State) -> Bool {
        switch (lhs, rhs) {
        case (.valid, .valid):
            return true
        case (.invalid(let lhsType), .invalid(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
             return false
        }
    }
}
